import 'package:flutter/material.dart';

class IconPickerDialog extends StatelessWidget {
  final List<IconData> _iconOptions = [
    Icons.home,
    Icons.favorite,
    Icons.settings,
    Icons.directions_run,
    Icons.star,
    Icons.work,
  ];

  IconPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('アイコンを選択'),
      content: SizedBox(
        width: double.maxFinite,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: _iconOptions.length,
          itemBuilder: (context, index) {
            return IconButton(
              icon: Icon(_iconOptions[index]),
              onPressed: () {
                Navigator.pop(context, _iconOptions[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
