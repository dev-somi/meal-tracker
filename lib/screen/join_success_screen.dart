import 'package:flutter/material.dart';
import 'package:food_expense_tracker/component/common_app_bar.dart';
import 'package:food_expense_tracker/constant/color.dart';

class JoinSuccessScreen extends StatelessWidget {
  const JoinSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 이미지의 배경색과 테마 색상을 변수로 설정
    const Color textColor = Color(0xFF4A3428); // 짙은 갈색 텍스트

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const CommonAppBar(title: ''),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              // 1. 상단 여백 (전체 남는 공간의 2만큼 차지)
              const Spacer(flex: 2),

              // 2. 메인 아이콘 (이미지의 체크 서클 스타일)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline_rounded,
                  size: 48,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),

              // 3. 텍스트 영역
              const Text(
                'Successfully Joined!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'You are now a member of the group.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFA6B8D1), // 이미지의 흐린 푸른빛 텍스트 색상
                ),
              ),
              const SizedBox(height: 48),

              // 4. 대시보드 버튼 (이미지 스타일 재현)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.pushAndRemoveUntil 사용 권장!
                      // 대시보드로 가는 로직 넣기
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Go to Dashboard',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),

              // 5. 하단 여백 (전체 남는 공간의 3만큼 차지하여 위로 밀어올림)
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}