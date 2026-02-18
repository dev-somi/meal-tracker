import 'package:flutter/material.dart';

// common_app_bar.dart 같은 파일에 만드세요.
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CommonAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title, // 화면마다 제목이 다르니 변수로 받습니다.
        style: TextStyle(
          color: const Color(0xFF4A3428), // textBrown 색상 직접 입력 또는 상수로 관리
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios_rounded),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  // AppBar는 크기를 미리 알려줘야 합니다. (보통 높이는 56.0)
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}