import 'package:animations_anatomy/provider/sync_bloc.dart';
import 'package:animations_anatomy/widgets/tapbar_widgets/top_tap_widget.dart';
import 'package:flutter/material.dart';

const categoryHeight = 55.0;
const productHeight = 100.0;

class TapBarScreen extends StatelessWidget {
  const TapBarScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: const [
            TopTapWidget(),
            Expanded(child: SyncConcept()),
          ],
        ),
      ),
    );
  }
}

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Colors.white,
          height: 80,
          child: TabBar(
            controller: _bloc.controller,
            isScrollable: true,
            tabs: _bloc.tabs.map((e) => SyncTabWidget(tabCategory: e)).toList(),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.grey[300],
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, index) {
                  return Container();
                },
                itemCount: 10),
          ),
        ),
      ],
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

class SyncCategoryItem extends StatelessWidget {
  const SyncCategoryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SyncProductItem extends StatelessWidget {
  const SyncProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
