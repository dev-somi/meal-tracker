import 'package:flutter/material.dart';

class ExpenseHistoryScreen extends StatefulWidget {
  @override
  _ExpenseHistoryScreenState createState() => _ExpenseHistoryScreenState();
}

class _ExpenseHistoryScreenState extends State<ExpenseHistoryScreen> {
  // 부모에서 관리하는 상태 데이터
  DateTime selectedDate = DateTime(2026, 2, 13);
  final double currentSpending = 178500;
  final double budget = 200000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBEB),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFE57373)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Expense History", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // 1. 주간 캘린더 위젯
            WeeklyCalendar(
              selectedDate: selectedDate,
              onDateSelected: (date) {
                setState(() => selectedDate = date);
              },
            ),
            const SizedBox(height: 20),

            // 2. 소비 요약 카드 위젯
            ExpenseSummaryCard(current: currentSpending, total: budget),
            const SizedBox(height: 20),

            // 3. 지출 내역 리스트 위젯
            const Expanded(child: ExpenseListView()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { /* 항목 추가 로직 */ },
        backgroundColor: const Color(0xFFE57373),
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class WeeklyCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const WeeklyCalendar({required this.selectedDate, required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    // 예시를 위해 9일부터 15일까지 생성
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        DateTime date = DateTime(2026, 2, 9 + index);
        bool isSelected = date.day == selectedDate.day;

        return GestureDetector(
          onTap: () => onDateSelected(date),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFE57373) : Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"][index],
                  style: TextStyle(fontSize: 10, color: isSelected ? Colors.white : Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  "${date.day}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.black87),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class ExpenseSummaryCard extends StatelessWidget {
  final double current;
  final double total;

  const ExpenseSummaryCard({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("WEEKLY TOTAL", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "₩${current.toInt()} ", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    TextSpan(text: "/ ₩${total.toInt()}", style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: current / total,
              minHeight: 10,
              backgroundColor: const Color(0xFFF5F5F5),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFE57373)),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpenseListView extends StatelessWidget {
  const ExpenseListView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const DateHeader(date: "09 FEBRUARY 2026", dailyTotal: "₩12,000"),
        const ExpenseItem(title: "Local Mart", payer: "Mom", amount: "12,000", icon: Icons.shopping_cart_outlined),
        const DateHeader(date: "10 FEBRUARY 2026", dailyTotal: "₩34,000"),
        const ExpenseItem(title: "Starbucks", payer: "Dad", amount: "6,000", icon: Icons.coffee),
        const ExpenseItem(title: "Pizza Hut", payer: "Somi", amount: "28,000", icon: Icons.local_pizza),
      ],
    );
  }
}

class DateHeader extends StatelessWidget {
  final String date;
  final String dailyTotal;
  const DateHeader({required this.date, required this.dailyTotal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(date, style: const TextStyle(color: Color(0xFFD4A373), fontWeight: FontWeight.bold, fontSize: 13)),
          Text(dailyTotal, style: const TextStyle(color: Color(0xFFD4A373), fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }
}

class ExpenseItem extends StatelessWidget {
  final String title;
  final String payer;
  final String amount;
  final IconData icon;

  const ExpenseItem({required this.title, required this.payer, required this.amount, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFFFFBEB),
            child: Icon(icon, color: Colors.orange[300]),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("Paid by $payer", style: const TextStyle(color: Color(0xFFE57373), fontSize: 12)),
              ],
            ),
          ),
          Text("₩$amount", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}