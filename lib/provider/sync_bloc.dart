import 'package:animations_anatomy/models/sync_tabbar.dart';
import 'package:flutter/material.dart';

class SyncBloc with ChangeNotifier {
  late TabController controller;
  late ScrollController scrollController;
  List<SyncTabCategory> tabs = [];
  List<SyncAllItem> allItems = [];

  void init(TickerProvider ticker) {
    controller = TabController(length: syncCategories.length, vsync: ticker);
    for (int i = 0; i < syncCategories.length; i++) {
      final singleCategory = syncCategories[i];
      tabs.add(SyncTabCategory(category: singleCategory, selected: i == 0));

      //adding all items & category line by line in a list name allItem[]
      allItems.add(SyncAllItem(
          hint: 'cat',
          category: singleCategory.name,
          product:
              const SyncProduct(title: '', details: '', image: '', price: 0)));
      for (int j = 0; j < singleCategory.products.length; j++) {
        final p = singleCategory.products[j];
        allItems.add(SyncAllItem(hint: 'pro', category: '', product: p));
      }
    }
    notifyListeners();
  }

  void onCategorySelected(int currentIndex) {
    final selected = tabs[currentIndex];
    for (int i = 0; i < tabs.length; i++) {
      tabs[i] = tabs[i]
          .changeSelection(selected.category.name == tabs[i].category.name);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    controller.dispose();
    super.dispose();
  }
}

class SyncTabCategory {
  final SyncCategory category;
  final bool selected;

  SyncTabCategory changeSelection(bool sel) =>
      SyncTabCategory(category: category, selected: sel);

  const SyncTabCategory({required this.category, required this.selected});
}

class SyncAllItem {
  final String hint;
  final String category;
  final SyncProduct product;

  const SyncAllItem(
      {required this.hint, required this.category, required this.product});
}
