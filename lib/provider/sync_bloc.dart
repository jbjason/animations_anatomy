import 'package:animations_anatomy/models/sync_tabbar.dart';
import 'package:flutter/material.dart';

class SyncBloc with ChangeNotifier {
  List<SyncTabCategory> tabs = [];
  late TabController controller;

  // first initializing
  void init(TickerProvider ticker) {
    controller = TabController(length: syncCategories.length, vsync: ticker);
    for (int i = 0; i < syncCategories.length; i++) {
      final category = syncCategories[i];
      tabs.add(SyncTabCategory(category: category, selected: i == 0));
    }
  }

  void onCategorySelected(int index) {}
}

class SyncTabCategory {
  final SyncCategory category;
  final bool selected;

  const SyncTabCategory({required this.category, required this.selected});
}
