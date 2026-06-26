import 'package:flutter/material.dart';

class HomPage extends StatelessWidget {
  const HomPage({super.key});

  @override
  Widget build(BuildContext context) {
    //본문으로 사용할 화면
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '여기는 진짜 홈 화면의 콘텐츠 영역입니다.',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: () {}, child: const Text('홈 화면 전용 버튼')),
        ],
      ),
    );
  }
}
