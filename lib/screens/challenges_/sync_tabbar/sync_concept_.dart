import 'package:animations_anatomy/screens/challenges_/sync_tabbar/sync_category_item.dart';
import 'package:animations_anatomy/screens/challenges_/sync_tabbar/sync_product_item.dart';
import 'package:flutter/material.dart';
import 'package:animations_anatomy/screens/challenges_/sync_tabbar/sync_bloc.dart';

const categoryHeight = 50.0;
const productHeight = 125.0;

class SyncConcept extends StatefulWidget {
  const SyncConcept({Key? key}) : super(key: key);
  @override
  State<SyncConcept> createState() => _SyncConceptState();
}

class _SyncConceptState extends State<SyncConcept>
    with SingleTickerProviderStateMixin {
  final _bloc = SyncBloc();

  @override
  void initState() {
    _bloc.init(this);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bloc,
      builder: (_, __) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: TabBar(
              controller: _bloc.tabController,
              isScrollable: true,
              indicatorColor: Colors.teal[900],
              onTap: (i) => _bloc.onCategorySelected(i),
              tabs:
                  _bloc.tabs.map((e) => SyncTabWidget(tabCategory: e)).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
                controller: _bloc.scrollController,
                itemBuilder: (context, index) {
                  final f = _bloc.allItems[index];
                  // if hint is cat means its a category
                  if (f.hint == 'cat') {
                    return SyncCategoryItem(title: f.category);
                  } else {
                    return SyncProductItem(product: f.product);
                  }
                },
                itemCount: _bloc.allItems.length),
          ),
        ],
      ),
    );
  }
}

class SyncTabWidget extends StatelessWidget {
  const SyncTabWidget({Key? key, required this.tabCategory}) : super(key: key);
  final SyncTabCategory tabCategory;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: tabCategory.selected ? 1 : 0.5,
      child: Card(
        elevation: tabCategory.selected ? 6 : 0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            tabCategory.category.name,
            style: TextStyle(
                color: Colors.blueGrey[800],
                fontWeight: FontWeight.bold,
                fontSize: 13),
          ),
        ),
      ),
    );
  }
}
