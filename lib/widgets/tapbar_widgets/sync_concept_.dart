import 'package:animations_anatomy/widgets/tapbar_widgets/sync_category_item.dart';
import 'package:animations_anatomy/widgets/tapbar_widgets/sync_product_item.dart';
import 'package:flutter/material.dart';
import 'package:animations_anatomy/provider/sync_bloc.dart';

const categoryHeight = 55.0;
const productHeight = 100.0;

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
            color: Colors.white,
            height: 80,
            child: TabBar(
              controller: _bloc.controller,
              isScrollable: true,
              onTap: (i) => _bloc.onCategorySelected(i),
              tabs:
                  _bloc.tabs.map((e) => SyncTabWidget(tabCategory: e)).toList(),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[300],
              child: ListView.builder(
                  controller: _bloc.scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.bold,
                fontSize: 13),
          ),
        ),
      ),
    );
  }
}
