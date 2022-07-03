import 'package:animations_anatomy/widgets/challenges_widgets/sliver2_widgets/card_delegate.dart';
import 'package:flutter/material.dart';

// image card rotating left & hide
class Sliver2Screen extends StatelessWidget {
  const Sliver2Screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              delegate: CardDelegate(
                  size: size,
                  maxExtend: size.height * .4,
                  minExtend: kToolbarHeight)),
          const SliverToBoxAdapter(
              child: Placeholder(color: Colors.transparent)),
          const SliverToBoxAdapter(
              child: Placeholder(color: Colors.transparent)),
          const SliverToBoxAdapter(
              child: Placeholder(color: Colors.transparent)),
        ],
      ),
    );
  }
}
