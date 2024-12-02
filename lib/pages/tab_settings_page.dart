
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/tab_model.dart';
import '../widgets/icon_picker_dialog.dart';

class TabSettingsPage extends StatefulWidget {
  final List<TabModel> allTabs;
  final Function(List<TabModel>) onUpdateTabs;

  const TabSettingsPage({
    super.key,
    required this.allTabs,
    required this.onUpdateTabs,
  });

  @override
  _TabSettingsPageState createState() => _TabSettingsPageState();
}

class _TabSettingsPageState extends State<TabSettingsPage> {
  late List<TabModel> tempTabs;
  late List<TextEditingController> _controllers;
  final Box<TabModel> _tabBox = Hive.box<TabModel>('tabs');

  @override
  void initState() {
    super.initState();
    tempTabs = List.from(widget.allTabs);
    _initControllers();
  }

  void _initControllers() {
    _controllers = tempTabs
        .map((tab) => TextEditingController(text: tab.label))
        .toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _toggleTab(TabModel tab) {
    setState(() {
      final index = tempTabs.indexWhere((t) => t.id == tab.id);
      if (index != -1) {
        tempTabs[index] = tempTabs[index].copyWith(isSelected: !tab.isSelected);
      }
    });
  }

  void _updateTabName(int index, String newName) {
    setState(() {
      tempTabs[index] = tempTabs[index].copyWith(label: newName);
    });
  }

  void _updateTabIcon(int index, IconData newIcon) {
    setState(() {
      tempTabs[index] = tempTabs[index].copyWith(iconCode: newIcon.codePoint);
    });
  }

  void _resetTabs() {
    setState(() {
      tempTabs = widget.allTabs.map((tab) => tab.copyWith()).toList();
      for (int i = 0; i < _controllers.length; i++) {
        _controllers[i].text = tempTabs[i].label;
      }
    });
  }

  Future<void> _saveTabs() async {
    await _tabBox.clear();
    for (var tab in tempTabs) {
      await _tabBox.add(tab);
    }
  }

  Future<IconData?> _showIconPicker(BuildContext context) async {
    return await showDialog<IconData>(
      context: context,
      builder: (context) => IconPickerDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('タブ設定'),
        actions: [
          TextButton(
            onPressed: _resetTabs,
            child: const Text(
              'デフォルトに戻す',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tempTabs.length,
        itemBuilder: (context, index) {
          final tab = tempTabs[index];
          return Card(
            child: ListTile(
              leading: IconButton(
                icon: Icon(tab.icon),
                onPressed: () async {
                  final selectedIcon = await _showIconPicker(context);
                  if (selectedIcon != null) {
                    _updateTabIcon(index, selectedIcon);
                  }
                },
              ),
              title: TextFormField(
                controller: _controllers[index],
                decoration: const InputDecoration(labelText: 'タブの名前を入力'),
                onChanged: (value) => _updateTabName(index, value),
              ),
              trailing: Checkbox(
                value: tab.isSelected,
                onChanged: (_) => _toggleTab(tab),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _saveTabs(); // Hiveに保存
          widget.onUpdateTabs(tempTabs); // 親ウィジェットに更新情報を渡す
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
