import 'package:flutter/material.dart';

import '../constant/color.dart';

class ActionButton extends StatelessWidget {
  final String text;          // 버튼에 들어갈 글자
  final VoidCallback? onPressed; // 클릭 시 실행할 함수 (null이면 자동 비활성화)
  final bool isLoading;       // (선택) 로딩 중 표시를 넣고 싶을 때

  const ActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false, // 기본값은 로딩 중 아님
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // isLoading이 true이거나 onPressed가 null이면 버튼은 비활성화됩니다.
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        disabledBackgroundColor: disabledButtonColor,
        disabledForegroundColor: Colors.white,
        // 버튼의 최소 높이를 설정해두면 디자인이 더 깔끔해집니다.
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: isLoading
          ? const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
      )
          : Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
    );
  }
}
