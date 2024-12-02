import 'package:flutter/material.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          '運動ページの内容',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
