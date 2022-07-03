import 'package:animations_anatomy/models/trip.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/sliver2_widgets/card_delegate.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/sliver2_widgets/sliver2_body.dart';
import 'package:flutter/material.dart';

// image card rotating left & hide
class Sliver2Screen extends StatelessWidget {
  const Sliver2Screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: CardDelegate(
                size: size,
                maxExtend: size.height * .4,
                minExtend: kTextTabBarHeight + 40),
          ),
          SliverToBoxAdapter(child: Sliver2Body(size: size, trip: trips[0])),
        ],
      ),
    );
  }
}
