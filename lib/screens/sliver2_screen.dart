import 'package:animations_anatomy/constants/constants.dart';
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
              delegate: _CardDelegate(
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

class _CardDelegate extends SliverPersistentHeaderDelegate {
  const _CardDelegate(
      {required this.maxExtend, required this.size, required this.minExtend});
  final double maxExtend, minExtend;
  final Size size;

  @override
  double get maxExtent => maxExtend;

  @override
  double get minExtent => minExtend;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double percent = (shrinkOffset / maxExtend).clamp(0.0, 1.0);
    const uploadLimit = 13 / 100.0;
    final double rotateBack = (1 - percent - .77).clamp(0.0, uploadLimit);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(travels[3].imageBack), fit: BoxFit.cover),
      ),
      child: Stack(children: [
        _ImageCard(size: size, percent: percent, rotateBack: rotateBack),
        Container(),
      ]),
    );
  }
}

class _ImageCard extends StatelessWidget {
  const _ImageCard(
      {Key? key,
      required this.rotateBack,
      required this.size,
      required this.percent})
      : super(key: key);
  final Size size;
  final double percent, rotateBack;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 20,
      child: Transform(
        alignment: Alignment.topRight,
        transform: Matrix4.identity()
          ..rotateZ(percent > .5 ? rotateBack * .6 : percent * .6),
        child: Container(
          width: size.width * .27,
          height: size.height * .18,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2, color: Colors.white)),
          child: Image.asset(travels[2].imageBack, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
