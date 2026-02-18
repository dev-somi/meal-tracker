import 'package:flutter/material.dart';
import 'package:food_expense_tracker/constant/color.dart';
import 'package:food_expense_tracker/screen/create_group_screen.dart';
import 'package:food_expense_tracker/screen/join_group_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _Top(),
            _Body(),
            _Bottom(
              onPressed_1: () => onGroupCreateButtonPressed(context),
              onPressed_2: () => onJoinGroupButtonPressed(context),
            ),
          ],
        ),
      ),
    );
  }

  void onGroupCreateButtonPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return CreateGroupScreen();
        },
      ),
    );
  }

  void onJoinGroupButtonPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return JoinGroupScreen();
        },
      ),
    );
  }
}

class _Top extends StatelessWidget {
  const _Top({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        "Meal Tracker",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        children: [
          Image.asset("asset/img/app_image.jpg"),
          SizedBox(height: 16),
          Text(
            textAlign: TextAlign.center,
            "Better spending, together",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 16),
          Text(
            textAlign: TextAlign.center,
            "Manage your shared expenses with friends, roommates, or partners in a cozy way.",
            style: TextStyle(color: textGrey, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  final VoidCallback onPressed_1;
  final VoidCallback onPressed_2;

  const _Bottom({
    super.key,
    required this.onPressed_1,
    required this.onPressed_2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton.icon(
            onPressed: onPressed_1,
            style: Theme.of(context).elevatedButtonTheme.style,
            icon: Icon(Icons.add, color: Colors.white, weight: 900),
            label: Text(
              "새로운 그룹 만들기",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: onPressed_2,
            style: Theme.of(context).outlinedButtonTheme.style,
            icon: Icon(
              Icons.person_add_alt_outlined,
              color: textBrown,
              weight: 900,
            ),
            label: Text(
              "초대코드로 함께하기",
              style: TextStyle(color: textBrown, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
