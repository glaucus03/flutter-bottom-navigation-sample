import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'お気に入りページの内容',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
