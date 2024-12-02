
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../pages/favorite_page.dart';
import '../pages/exercise_page.dart';
import '../pages/stats_page.dart';
import '../pages/notification_page.dart';
import '../pages/calendar_page.dart';
import '../pages/profile_page.dart';

part 'tab_model.g.dart';

@HiveType(typeId: 0)
class TabModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int iconCode;

  @HiveField(2)
  final String label;

  @HiveField(3)
  final bool isSelected;

  @HiveField(4)
  final String? pageKey; // 各画面を識別するためのキー

  TabModel({
    required this.id,
    required this.iconCode,
    required this.label,
    required this.isSelected,
    this.pageKey,
  });

  IconData get icon => IconData(iconCode, fontFamily: 'MaterialIcons');

  Widget? get page {
    // pageKeyを基に画面を動的に生成
    switch (pageKey) {
      case 'FavoritePage':
        return const FavoritePage();
      case 'ExercisePage':
        return const ExercisePage();
      case 'StatsPage':
        return const StatsPage();
      case 'NotificationsPage':
        return const NotificationsPage();
      case 'CalendarPage':
        return const CalendarPage();
      case 'ProfilePage':
        return const ProfilePage();
      default:
        return null; // 設定画面などの特殊ケース
    }
  }

  TabModel copyWith({
    int? id,
    int? iconCode,
    String? label,
    bool? isSelected,
    String? pageKey,
  }) {
    return TabModel(
      id: id ?? this.id,
      iconCode: iconCode ?? this.iconCode,
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
      pageKey: pageKey ?? this.pageKey,
    );
  }
}
