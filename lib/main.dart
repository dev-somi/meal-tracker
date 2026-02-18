import 'package:flutter/material.dart';
import 'package:food_expense_tracker/constant/color.dart';
import 'package:food_expense_tracker/screen/create_group_screen.dart';
import 'package:food_expense_tracker/screen/dashboard_screen.dart';
import 'package:food_expense_tracker/screen/expense_history_screen.dart';
import 'package:food_expense_tracker/screen/home_screen.dart';
import 'package:food_expense_tracker/screen/test_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Make Group',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: secondaryColor,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: backgroundColor,
          onSurface: textBrown,
        ),

        // TextField 공통설정
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),

        // 🔘 모든 ElevatedButton의 공통 설정
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w900),
          ),
        ),

        // OutlinedButton
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: textGrey),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w900),
          ),
        ),

        // 텍스트 테마
        textTheme: GoogleFonts.quicksandTextTheme().copyWith(
          // [Display] 메인 잔액 (₩50,000)
          displaySmall: GoogleFonts.quicksand(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: textBrown, // 기존에 정의하신 변수 사용
          ),

          // [Headline] 메인 슬로건 (Better spending, together.)
          headlineMedium: GoogleFonts.quicksand(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textBrown,
            height: 1.2,
          ),

          // [Title] 카드 제목 (GROCERIES, EATING OUT)
          titleMedium: GoogleFonts.quicksand(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
            color: textBrown.withOpacity(0.5), // 보조 정보는 투명도로 조절
          ),

          // [Body] 일반 본문 및 메시지
          bodyMedium: GoogleFonts.quicksand(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.5,
            color: textBrown.withOpacity(0.8),
          ),

          // [Label] 버튼 내부 텍스트
          labelLarge: GoogleFonts.quicksand(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),

        fontFamily: GoogleFonts.quicksand().fontFamily,
      ),

      home: HomeScreen(),
    ),
  );
}
