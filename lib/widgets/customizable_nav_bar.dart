import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/tab_model.dart';
import '../pages/tab_settings_page.dart';

class CustomizableNavBar extends StatefulWidget {
  const CustomizableNavBar({super.key});

  @override
  _CustomizableNavBarState createState() => _CustomizableNavBarState();
}

class _CustomizableNavBarState extends State<CustomizableNavBar> {
  int _currentIndex = 0;
  late List<TabModel> _customizableTabs;
  late List<TabModel> _selectedTabs;
  final Box<TabModel> _tabBox = Hive.box<TabModel>('tabs');

  final TabModel _homeTab = TabModel(
    id: 0,
    iconCode: Icons.home.codePoint,
    label: 'ホーム',
    isSelected: true,
    pageKey: null,
  );

  final TabModel _settingsTab = TabModel(
    id: 999,
    iconCode: Icons.settings.codePoint,
    label: '設定',
    isSelected: true,
    pageKey: null,
  );

  @override
  void initState() {
    super.initState();
    _loadTabs();
  }

  void _loadTabs() {
    if (_tabBox.isNotEmpty) {
      setState(() {
        _customizableTabs = _tabBox.values.toList();
        _selectedTabs =
            _customizableTabs.where((tab) => tab.isSelected).toList();
      });
    } else {
      setState(() {
        _customizableTabs = [
          TabModel(
              id: 1,
              iconCode: Icons.favorite.codePoint,
              label: 'お気に入り',
              isSelected: true,
              pageKey: 'FavoritePage'),
          TabModel(
              id: 2,
              iconCode: Icons.directions_run.codePoint,
              label: '運動',
              isSelected: true,
              pageKey: 'ExercisePage'),
          TabModel(
              id: 3,
              iconCode: Icons.bar_chart.codePoint,
              label: '統計',
              isSelected: false,
              pageKey: 'StatsPage'),
          TabModel(
              id: 4,
              iconCode: Icons.notifications.codePoint,
              label: '通知',
              isSelected: false,
              pageKey: 'NotificationsPage'),
          TabModel(
              id: 5,
              iconCode: Icons.calendar_today.codePoint,
              label: 'カレンダー',
              isSelected: false,
              pageKey: 'CalendarPage'),
          TabModel(
              id: 6,
              iconCode: Icons.person.codePoint,
              label: 'プロファイル',
              isSelected: false,
              pageKey: 'ProfilePage'),
        ];
        _selectedTabs =
            _customizableTabs.where((tab) => tab.isSelected).toList();
        _saveTabs();
      });
    }
  }

  void _saveTabs() {
    _tabBox.clear();
    for (var tab in _customizableTabs) {
      _tabBox.add(tab);
    }
  }

  List<TabModel> _generateTabs() {
    return [
      _homeTab,
      ..._selectedTabs,
      _settingsTab,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final tabs = _generateTabs();

    return Scaffold(
      appBar: AppBar(
        title: Text(tabs[_currentIndex].label),
      ),
      body: tabs[_currentIndex].page ?? const Center(child: Text('設定画面')),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) async {
          if (tabs[index].id == _settingsTab.id) {
            final updatedTabs = await Navigator.push<List<TabModel>>(
              context,
              MaterialPageRoute(
                builder: (context) => TabSettingsPage(
                  allTabs: _customizableTabs,
                  onUpdateTabs: (tabs) {
                    setState(() {
                      _customizableTabs = tabs.whereType<TabModel>().toList();
                      _selectedTabs =
                          _customizableTabs.where((tab) => tab.isSelected).toList();
                    });
                    _saveTabs();
                  },
                ),
              ),
            );

            if (updatedTabs != null) {
              setState(() {
                _customizableTabs = updatedTabs;
                _selectedTabs =
                    updatedTabs.where((tab) => tab.isSelected).toList();
              });
            }
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: tabs
            .map((tab) => BottomNavigationBarItem(
                  icon: Icon(IconData(tab.iconCode, fontFamily: 'MaterialIcons')),
                  label: tab.label,
                ))
            .toList(),
      ),
    );
  }
}
