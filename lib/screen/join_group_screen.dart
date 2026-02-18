import 'package:flutter/material.dart';
import 'package:food_expense_tracker/component/common_app_bar.dart';
import 'package:food_expense_tracker/screen/join_success_screen.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';

import '../constant/color.dart';
import '../data/services/group_service.dart';

class JoinGroupScreen extends StatefulWidget {
  const JoinGroupScreen({super.key});

  @override
  State<JoinGroupScreen> createState() => _JoinGroupScreenState();
}

class _JoinGroupScreenState extends State<JoinGroupScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  bool isInputEmpty = true;

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 소미님이 올린 이미지와 비슷한 색감/테마 설정
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color(0xFF4A3428), // textBrown 대용
        fontWeight: FontWeight.w900,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F7EF), // 연한 배경색
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF5), // 배경색
      appBar: CommonAppBar(title: "Join Group"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //const Spacer(flex: 1), // 상단 여백 (전체 남는 공간의 2/5 차지)
              const Text(
                "Enter the 6-digit invite code",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueGrey, fontSize: 16),
              ),
              const SizedBox(height: 32),
              Pinput(
                length: 6,
                controller: pinController,
                focusNode: focusNode,
                defaultPinTheme: defaultPinTheme,
                // 포커스 되었을 때 테두리 색상 변경
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: const Color(0xFF4A3428), width: 2),
                  ),
                ),

                submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: primaryColor, width: 2),
                      color: Colors.white
                    ),
                ),

                onCompleted: (pin) {
                  // 6자리 다 치면 실행할 로직 (서버 통신 등)

                  // 프론트엔드 로직 : ElevatedButton 활성화
                  // 서버 통신 : 유효성 검사
                  setState(() {
                    print('입력된 코드: $pin');
                    print('입력된 코드 : ${pinController.text}');
                    isInputEmpty = pin.length < 6;
                  });
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: isInputEmpty ? null : () async {
                  try {
                    // 1. URL 직접 만들기 (userId=1 고정, pin은 입력값)
                    final url = Uri.parse('http://192.168.0.56:8080/api/groups/join?userId=1&inviteCode=${pinController.text}');

                    print("🚀 서버로 쏜다! 주소: $url");

                    // 2. 서버에 POST 요청 보내기 (5초 지나면 포기)
                    final response = await http.post(url).timeout(const Duration(seconds: 5));

                    print("✅ 응답 왔다! 코드: ${response.statusCode}");
                    print("📝 응답 내용: ${response.body}");

                    if (!mounted) return;

                    // 3. 응답 코드에 따른 결과 처리 (200 혹은 201이면 성공)
                    if (response.statusCode == 200 || response.statusCode == 201) {
                      print("🎉 가입 성공! 화면 넘어감");
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const JoinSuccessScreen()),
                      );
                    } else {
                      print("❌ 가입 실패 (코드 틀림 등)");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("실패: ${response.statusCode} / ${response.body}")),
                      );
                    }
                  } catch (e) {
                    // 네트워크 연결 자체가 안 될 때 (IP 틀림, 와이파이 다름 등)
                    print("🚨 으악! 에러 발생: $e");
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("서버 연결 실패! IP 주소나 와이파이 확인해봐!")),
                    );
                  }
                },
                child: Text("Join Group"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: disabledButtonColor,
                  disabledForegroundColor: Colors.white,
                ),
              ),
              //const Spacer(flex: 4), // 하단 여백 (전체 남는 공간의 3/5 차지)
            ],

          ),
        ),
      ),
    );
  }
}