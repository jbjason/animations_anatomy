import 'package:flutter/material.dart';

class FbChlng1Screen extends StatelessWidget {
  const FbChlng1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: FbChlngDelegate(
              maxExtend: size.height * .4,
              minExtend: kTextTabBarHeight + 30,
              size: size,
            ),
          ),
          const SliverToBoxAdapter(child: Placeholder()),
          const SliverToBoxAdapter(child: Placeholder()),
          const SliverToBoxAdapter(child: Placeholder()),
        ],
      ),
    );
  }
}

class FbChlngDelegate extends SliverPersistentHeaderDelegate {
  const FbChlngDelegate(
      {required this.maxExtend, required this.size, required this.minExtend});
  final double maxExtend, minExtend;
  final Size size;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // final double percent = (shrinkOffset / maxExtend).clamp(0, 1.0);
    return Container(
      color: Colors.grey[900],
    );
  }

  @override
  double get maxExtent => maxExtend;

  @override
  double get minExtent => minExtend;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
