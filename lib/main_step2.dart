import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bottom Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.notoSansJpTextTheme(
          Theme.of(context).textTheme,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
        ),
      ),
      home: const CustomizableNavBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('ホームページ'));
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('設定ページ'));
  }
}

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('お気に入りページ'));
  }
}

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('運動ページ'));
  }
}

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('統計ページ'));
  }
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('通知ページ'));
  }
}

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('カレンダーページ'));
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('プロファイルページ'));
  }
}

List<Map<String, dynamic>> cloneTabList(List<Map<String, dynamic>> tabs) {
  return tabs.map((tab) => Map<String, dynamic>.from(tab)).toList();
}

class CustomizableNavBar extends StatefulWidget {
  const CustomizableNavBar({super.key});

  @override
  _CustomizableNavBarState createState() => _CustomizableNavBarState();
}

class _CustomizableNavBarState extends State<CustomizableNavBar> {
  int _currentIndex = 0;

  late List<Map<String, dynamic>> _customizableTabs;
  late List<Map<String, dynamic>> _selectedTabs;

  // 固定タブ（ホーム、設定）
  final Map<String, dynamic> _homeTab = {
    'icon': Icons.home,
    'label': 'ホーム',
    'page': const HomePage(),
  };

  final Map<String, dynamic> _settingsTab = {
    'icon': Icons.settings,
    'label': '設定',
    'page': null,
  };

  // デフォルトのカスタマイズ可能タブ
  final List<Map<String, dynamic>> _defaultCustomizableTabs = [
    {
      'id': 1,
      'icon': Icons.favorite,
      'label': 'お気に入り',
      'page': const FavoritePage()
    },
    {
      'id': 2,
      'icon': Icons.directions_run,
      'label': '運動',
      'page': const ExercisePage()
    },
    {
      'id': 3,
      'icon': Icons.bar_chart,
      'label': '統計',
      'page': const StatsPage()
    },
    {
      'id': 4,
      'icon': Icons.notifications,
      'label': '通知',
      'page': const NotificationsPage()
    },
    {
      'id': 5,
      'icon': Icons.calendar_today,
      'label': 'カレンダー',
      'page': const CalendarPage()
    },
    {
      'id': 6,
      'icon': Icons.person,
      'label': 'プロファイル',
      'page': const ProfilePage()
    },
  ];

  // デフォルト選択タブ
  final List<Map<String, dynamic>> _defaultSelectedTabs = [
    {
      'id': 1,
      'icon': Icons.favorite,
      'label': 'お気に入り',
      'page': const FavoritePage()
    },
    {
      'id': 2,
      'icon': Icons.directions_run,
      'label': '運動',
      'page': const ExercisePage()
    },
  ];

  @override
  void initState() {
    super.initState();
    _customizableTabs = List.from(_defaultCustomizableTabs);
    _selectedTabs = List.from(_defaultSelectedTabs);
  }

  // タブ構成を作成する関数
  List<Map<String, dynamic>> _generateTabs() {
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
        title: const Flexible(
          child: Text(
            'ボトムナビゲーションを自由にカスタマイズ可能な例',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      body: tabs[_currentIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) async {
          if (tabs[index]['label'] == '設定') {
            // 設定画面に遷移
            final updatedTabs =
                await Navigator.push<List<Map<String, dynamic>>>(
              context,
              MaterialPageRoute(
                builder: (context) => TabSettingsPage(
                  allTabs: _customizableTabs,
                  selectedTabs: _selectedTabs,
                  defaultTabs: _defaultCustomizableTabs,
                  onUpdateSelectedTabs: (tabs) =>
                      setState(() => _selectedTabs = tabs),
                  onUpdateCustomizableTabs: (tabs) =>
                      setState(() => _customizableTabs = tabs),
                ),
              ),
            );

            if (updatedTabs != null) {
              setState(() {
                _customizableTabs = updatedTabs;
              });
            }
          } else {
            // 通常のタブ切り替え
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: tabs
            .map((tab) => BottomNavigationBarItem(
                  icon: Icon(tab['icon']),
                  label: tab['label'],
                ))
            .toList(),
      ),
    );
  }
}

class TabSettingsPage extends StatefulWidget {
  final List<Map<String, dynamic>> allTabs;
  final List<Map<String, dynamic>> selectedTabs;
  final List<Map<String, dynamic>> defaultTabs;
  final Function(List<Map<String, dynamic>>) onUpdateSelectedTabs;
  final Function(List<Map<String, dynamic>>) onUpdateCustomizableTabs;

  const TabSettingsPage({
    super.key,
    required this.allTabs,
    required this.selectedTabs,
    required this.defaultTabs,
    required this.onUpdateSelectedTabs,
    required this.onUpdateCustomizableTabs,
  });

  @override
  _TabSettingsPageState createState() => _TabSettingsPageState();
}

class _TabSettingsPageState extends State<TabSettingsPage> {
  late List<Map<String, dynamic>> tempSelectedTabs;
  late List<Map<String, dynamic>> tempCustomizableTabs;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    tempSelectedTabs = cloneTabList(widget.selectedTabs);
    tempCustomizableTabs = cloneTabList(widget.allTabs);
    _initControllers(); // 初期化関数の呼び出し
  }

  void _initControllers() {
    _controllers = tempCustomizableTabs
        .map((tab) => TextEditingController(text: tab['label']))
        .toList();
  }

  @override
  void dispose() {
    // コントローラーを解放
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  bool _isSelected(int id) {
    return tempSelectedTabs.any((tab) => tab['id'] == id);
  }

  void _toggleTab(Map<String, dynamic> tab) {
    setState(() {
      if (_isSelected(tab['id'])) {
        tempSelectedTabs
            .removeWhere((selectedTab) => selectedTab['id'] == tab['id']);
      } else {
        if (tempSelectedTabs.length < 4) {
          tempSelectedTabs.add(tab);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('タブは最大4つまで選択できます。')),
          );
        }
      }
    });
  }

  void _resetTabs() {
    setState(() {
      // デフォルトのタブリストを完全にコピー
      tempCustomizableTabs = cloneTabList(widget.defaultTabs);
      // デフォルトの選択タブもリセット
      tempSelectedTabs = tempCustomizableTabs.take(2).toList();

      // TextEditingControllerの内容をリセット
      for (int i = 0; i < _controllers.length; i++) {
        _controllers[i].text = tempCustomizableTabs[i]['label'] as String;
      }
    });
  }


void _updateTabName(int index, String newName) {
  setState(() {
    // tempCustomizableTabs のラベルを更新
    tempCustomizableTabs[index]['label'] = newName;

    // tempSelectedTabs 内の該当タブを更新
    for (var selectedTab in tempSelectedTabs) {
      if (selectedTab['id'] == tempCustomizableTabs[index]['id']) {
        selectedTab['label'] = newName;
        break;
      }
    }
  });
}

  void _updateTabIcon(int index, IconData newIcon) {
    setState(() {
      tempCustomizableTabs[index]['icon'] = newIcon;

    // tempSelectedTabs 内の該当タブを更新
    for (var selectedTab in tempSelectedTabs) {
      if (selectedTab['id'] == tempCustomizableTabs[index]['id']) {
        selectedTab['icon'] = newIcon;
        break;
      }
    }
    });
  }

  void _showIconPicker(int index) async {
    final IconData? selectedIcon = await showDialog<IconData>(
      context: context,
      builder: (context) => IconPickerDialog(),
    );

    if (selectedIcon != null) {
      _updateTabIcon(index, selectedIcon);
    }
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
        itemCount: tempCustomizableTabs.length,
        itemBuilder: (context, index) {
          final tab = tempCustomizableTabs[index];
          return Card(
            child: ListTile(
              leading: IconButton(
                icon: Icon(tab['icon']),
                onPressed: () => _showIconPicker(index), // アイコン変更
              ),
              title: TextFormField(
                controller: _controllers[index],
                decoration: const InputDecoration(labelText: 'タブの名前を入力'),
                onChanged: (value) => _updateTabName(index, value), // 名前変更
              ),
              trailing: Checkbox(
                value: _isSelected(tab['id']),
                onChanged: (_) => _toggleTab(tab),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(tempSelectedTabs);
          print(tempCustomizableTabs);
          widget.onUpdateSelectedTabs(tempSelectedTabs);
          widget.onUpdateCustomizableTabs(tempCustomizableTabs);
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
