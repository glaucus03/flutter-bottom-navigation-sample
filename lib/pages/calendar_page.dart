import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'カレンダーページの内容',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
