import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          '統計ページの内容',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
