import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'プロファイルページの内容',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
