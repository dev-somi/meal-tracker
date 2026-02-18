import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {

  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 1. 컨트롤러 생성
        
            // 2. TextField에 연결
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: '이름을 입력하세요'),
            ),
        
            // 3. 값 사용하기
            ElevatedButton(
              onPressed: () {
                print(_controller.text); // 입력된 값 출력!
              },
              child: Text('확인'),
            ),
          ],
        ),
      ),
    );
  }
}
