import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          '通知ページの内容',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
