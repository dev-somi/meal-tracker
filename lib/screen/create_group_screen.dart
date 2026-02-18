import 'package:flutter/material.dart';
import 'package:food_expense_tracker/constant/color.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../component/common_app_bar.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  bool _isInputEmpty = true;
  bool _isCreated = false;
  String _groupName = "";
  String _inviteCode = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CommonAppBar(title: "Create Group"),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Input(
                isInputEmpty: _isInputEmpty,
                onChanged: _handleInputChange,
              ),
              const SizedBox(height: 16),
              _isCreated
                  ? _Display(inviteCode: _inviteCode,)
                  : _ButtonArea(
                    isInputEmpty: _isInputEmpty,
                    onPressed: () => _handleCreateGroup(_groupName),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleInputChange(String value) {
    setState(() {
      _isInputEmpty = value.isEmpty;
      _groupName = value;
    });
  }

  void _handleCreateGroup(String groupName) async {
    // 여기에 서버에서 초대코드 받아오기 로직 들어갈 것
    // 로딩 상태 등을 표시하고 싶다면 여기서 처리

    try {
      final url = Uri.parse('http://192.168.0.56:8080/api/groups?name=$groupName');
      final response = await http.post(url).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        setState(() {
          _inviteCode = data['inviteCode']; // 3. 서버에서 받은 진짜 코드 저장
          _isCreated = true; // 화면 전환
        });
      }
    } catch (e) {
      print("🚨 에러: $e");
    }
  }
}

class _Input extends StatelessWidget {
  final bool isInputEmpty;
  final ValueChanged<String> onChanged;

  const _Input({
    super.key,
    required this.isInputEmpty,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "GROUP NAME",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),
        ),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(), // 외곽 테두리 스타일
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
            hintText: 'e.g. Food Budget', // 값이 없을 때 보여주는 힌트
            hintStyle: TextStyle(color: secondaryColor),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _Display extends StatelessWidget {
  final String inviteCode;
  const _Display({super.key, required this.inviteCode});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_InviteCodeBox(inviteCode: inviteCode,), SizedBox(height: 32), _ShareButtonActions()],
    );
  }
}

class _InviteCodeBox extends StatelessWidget {
  final String inviteCode;

  const _InviteCodeBox({super.key, required this.inviteCode});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      color: onPink,
      radius: Radius.circular(20),
      dashPattern: [9, 5],
      strokeWidth: 1.5,
      child: Container(
        decoration: BoxDecoration(
          color: pink,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 0, 16),
          child: Column(
            children: [
              Text(
                'Your Invite Code',
                style: TextStyle(color: onPink, fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 6자리의 난수
                    Text(
                      '$inviteCode',
                      style: TextStyle(
                        color: textBrown,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(width: 12),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                0.1,
                              ), // 🌚 연한 검정색 그림자
                              spreadRadius: 1, // 🎈 그림자 확장 정도
                              blurRadius: 10, // ✨ 부드러운 정도
                              offset: Offset(0, 2), // 📍 아래로 4만큼 이동
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            // 누르면 복사가 되도록
                            Clipboard.setData(
                              ClipboardData(text: inviteCode),
                            ).then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('초대코드가 복사되었습니다!'),
                                  backgroundColor: primaryColor,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                          icon: Icon(Icons.copy, color: onPink),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShareButtonActions extends StatelessWidget {
  const _ShareButtonActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Text(
              'Share this code with your friends',
              style: TextStyle(color: textGrey),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                _SNSButton(
                  label: 'Line',
                  icon: Icons.chat_bubble,
                  iconBgColor: Colors.green,
                  iconColor: Colors.white,
                  onPressed: () {
                    SharePlus.instance.share(
                      ShareParams(
                        text: 'check out my website https://example.com',
                      ),
                    );
                  },
                ),

                SizedBox(width: 15),
                _SNSButton(
                  label: 'Kakao',
                  icon: Icons.chat_bubble,
                  iconBgColor: Colors.yellow,
                  iconColor: textBrown,
                  onPressed: () {},
                ),
                SizedBox(width: 15),

                _SNSButton(
                  label: 'More',
                  icon: Icons.share_outlined,
                  iconBgColor: Colors.blue,
                  iconColor: Colors.white,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _ButtonArea extends StatelessWidget {
  final bool isInputEmpty;
  final VoidCallback? onPressed;

  const _ButtonArea({
    super.key,
    required this.isInputEmpty,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isInputEmpty ? null : onPressed,
      child: Text("Generate Group"),
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        disabledBackgroundColor: disabledButtonColor,
        disabledForegroundColor: Colors.white,
      ),
    );
  }
}

class _SNSButton extends StatelessWidget {
  // 1. 받아올 데이터 선언 (데이터 타입 주의)
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final VoidCallback onPressed;

  // 2. 생성자 만들기
  const _SNSButton({
    super.key,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.grey,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Icon(icon, color: iconColor, size: 24),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconBgColor,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '$label',
                style: TextStyle(color: textBrown, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
