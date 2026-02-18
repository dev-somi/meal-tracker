import 'package:flutter/material.dart';
import 'package:food_expense_tracker/screen/expense_history_screen.dart';

// 기간 선택을 위한 Enum
enum BudgetPeriod { weekly, monthly }

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // 상태 관리: 현재 선택된 기간
  BudgetPeriod selectedPeriod = BudgetPeriod.weekly;

  // 공통 테마 컬러
  static const primaryColor = Color(0xFFE57A61);
  static const bgColor = Color(0xFFFFF9E9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardHeader(), // 상수 생성자로 최적화
              const SizedBox(height: 25),
              PeriodToggleButton(
                selectedPeriod: selectedPeriod,
                onChanged: (period) => setState(() => selectedPeriod = period),
              ),
              const SizedBox(height: 25),
              // 애니메이션 스위처 적용
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: MainBudgetCard(
                  key: ValueKey(selectedPeriod),
                  period: selectedPeriod,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      title: "GROCERIES",
                      amount:
                          selectedPeriod == BudgetPeriod.weekly
                              ? "₩82,400"
                              : "₩345,000",
                      progress: 0.6,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: SummaryCard(
                      title: "EATING OUT",
                      amount:
                          selectedPeriod == BudgetPeriod.weekly
                              ? "₩67,600"
                              : "₩210,000",
                      progress: 0.4,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const BottomPromoBanner(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(primaryColor: primaryColor),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        elevation: 2,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// --- 분리된 위젯 클래스들 ---

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "MealTrack",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE57A61),
              ),
            ),
            Text(
              "FAMILY BUDGET",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: 22,
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=32'),
        ),
      ],
    );
  }
}

class PeriodToggleButton extends StatelessWidget {
  final BudgetPeriod selectedPeriod;
  final ValueChanged<BudgetPeriod> onChanged;

  const PeriodToggleButton({
    super.key,
    required this.selectedPeriod,
    required this.onChanged,
  });

  // 컬러와 수치를 상수로 빼서 관리하면 수정이 편합니다.
  static const Color _primaryColor = Color(0xFFE57A61);
  static const Color _bgColor = Color(0xFFFFF9F0);
  static const double _height = 50.0;
  static const double _borderRadius = 25.0; // 더 알약 모양에 가깝게

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      padding: const EdgeInsets.all(4), // 내부 칩과의 간격
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(_borderRadius),
        border: Border.all(color: _primaryColor.withOpacity(0.1)),
      ),
      child: Stack(
        children: [
          // 1. 배경에서 움직이는 슬라이더 (Chip)
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut, // 애니메이션 곡선 추가로 더 쫀득하게
            alignment:
                selectedPeriod == BudgetPeriod.weekly
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                decoration: BoxDecoration(
                  color: _primaryColor,
                  borderRadius: BorderRadius.circular(_borderRadius - 4),
                  boxShadow: [
                    BoxShadow(
                      color: _primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 2. 상단 텍스트 레이어
          Row(
            children: [
              _buildLabel("Weekly", BudgetPeriod.weekly),
              _buildLabel("Monthly", BudgetPeriod.monthly),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String label, BudgetPeriod period) {
    final bool isSelected = selectedPeriod == period;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          print('clicked');
          onChanged(period);
        },
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedDefaultTextStyle(
            // 텍스트 색상 변화도 애니메이션 적용
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: isSelected ? Colors.white : _primaryColor.withOpacity(0.6),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}

class MainBudgetCard extends StatelessWidget {
  final BudgetPeriod period;

  const MainBudgetCard({super.key, required this.period});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFFE57A61);
    final isWeekly = period == BudgetPeriod.weekly;

    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ExpenseHistoryScreen();
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isWeekly ? "Left for 7 Days >" : "Left for this Month >",
                  style: const TextStyle(color: Colors.grey),
                ),
                Icon(Icons.trending_down, color: Colors.teal.shade300),
              ],
            ),
            Text(
              isWeekly ? "₩50,000" : "₩425,000",
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 15),
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 500), // 애니메이션 속도
              curve: Curves.easeInOut, // 애니메이션 곡선
              tween: Tween<double>(begin: 0, end: isWeekly ? 0.75 : 0.58),
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  value: value, // 빌더에서 전달받은 애니메이션 값 사용
                  backgroundColor: Colors.grey.shade100,
                  color: primary,
                  minHeight: 12,
                  borderRadius: BorderRadius.circular(10),
                );
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isWeekly ? "₩150,000 spent" : "₩575,000 spent",
                  style: const TextStyle(
                    color: primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  isWeekly ? "₩200,000 goal" : "₩1,000,000 goal",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 25),
            const StatusMessageBanner(),
          ],
        ),
      ),
    );
  }
}

class StatusMessageBanner extends StatelessWidget {
  const StatusMessageBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFEEFBF5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        children: [
          Icon(Icons.check_circle, color: Color(0xFF27AE60), size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "You are on track! Great job keeping the budget lean.",
              style: TextStyle(
                color: Color(0xFF1E6F41),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final double progress;

  const SummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress,
            color: const Color(0xFFE57A61),
            backgroundColor: Colors.grey.shade100,
            minHeight: 4,
          ),
        ],
      ),
    );
  }
}

class BottomPromoBanner extends StatelessWidget {
  const BottomPromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1547592166-23ac45744acd?q=80&w=1000',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final Color primaryColor;
  const CustomBottomNavBar({super.key, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home,
              label: "Home",
              color: primaryColor,
              isActive: true,
            ),
            const _NavItem(
              icon: Icons.list_alt,
              label: "History",
              color: Colors.grey,
              isActive: false,
            ),
            const SizedBox(width: 40),
            const _NavItem(
              icon: Icons.pie_chart_outline,
              label: "Analytics",
              color: Colors.grey,
              isActive: false,
            ),
            const _NavItem(
              icon: Icons.settings_outlined,
              label: "Settings",
              color: Colors.grey,
              isActive: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isActive;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
