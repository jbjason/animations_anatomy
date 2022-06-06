import 'package:animations_anatomy/models/sync_tabbar.dart';
import 'package:animations_anatomy/widgets/tapbar_widgets/sync_concept_.dart';
import 'package:flutter/material.dart';

class SyncBloc with ChangeNotifier {
  late TabController controller;
  late ScrollController scrollController;
  List<SyncTabCategory> tabs = [];
  List<SyncAllItem> allItems = [];
  double offset = 0.0;

  void init(TickerProvider ticker) {
    controller = TabController(length: syncCategories.length, vsync: ticker);
    scrollController = ScrollController();
    for (int i = 0; i < syncCategories.length; i++) {
      final singleCategory = syncCategories[i];

      // storing categories exact offset , this will help to go that selected category's offset postion
      if (i != 0) {
        offset += syncCategories[i - 1].products.length * productHeight;
      }
      // declaring all tabs  selected element to false except 0
      tabs.add(SyncTabCategory(
        category: singleCategory,
        selected: i == 0 ? true : false,
        offset: offset + (i * categoryHeight),
      ));

      //adding all items & category line by line in a list name allItem[]
      const emptyProduct =
          SyncProduct(title: '', details: '', image: '', price: 0);
      allItems.add(SyncAllItem(
          hint: 'cat', category: singleCategory.name, product: emptyProduct));
      for (int j = 0; j < singleCategory.products.length; j++) {
        final product = singleCategory.products[j];
        allItems.add(SyncAllItem(hint: 'pro', category: '', product: product));
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
    scrollController.animateTo(selected.offset,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInCubic);
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
  final double offset;

  SyncTabCategory changeSelection(bool sel) =>
      SyncTabCategory(category: category, offset: offset, selected: sel);

  const SyncTabCategory(
      {required this.category, required this.offset, required this.selected});
}

class SyncAllItem {
  final String hint;
  final String category;
  final SyncProduct product;

  const SyncAllItem(
      {required this.hint, required this.category, required this.product});
}
