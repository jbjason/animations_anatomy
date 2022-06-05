import 'package:animations_anatomy/constants/constants.dart';
import 'package:animations_anatomy/widgets/sliver2_widgets/cutting_clipper.dart';
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
    // starting to breakPoint
    final double percent = (shrinkOffset / maxExtend).clamp(0, 1.0);

    const uploadLimit = 13 / 100.0;
    // breakPoint to rotateBack
    final valueBack = (1 - percent - .77).clamp(0.0, uploadLimit);
    final _clippedContainer =
        _ClippedContainer(size: size, percent: percent, valueBack: valueBack);
    final _imageCard = _ImageCard(
      size: size,
      percent: percent,
      valueBack: valueBack,
      uploadLimit: uploadLimit,
    );

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(travels[3].imageBack), fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          if (percent > uploadLimit) ...[
            _imageCard,
            _clippedContainer,
          ] else ...[
            _clippedContainer,
            _imageCard,
          ]
        ],
      ),
    );
  }
}

class _ImageCard extends StatelessWidget {
  const _ImageCard(
      {Key? key,
      required this.valueBack,
      required this.uploadLimit,
      required this.size,
      required this.percent})
      : super(key: key);
  final Size size;
  final double percent, valueBack, uploadLimit;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 20,
      child: Transform(
        alignment: Alignment.topRight,
        transform: Matrix4.identity()
          ..rotateZ(percent > uploadLimit ? valueBack * 5 : percent * 5),
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

class _ClippedContainer extends StatelessWidget {
  const _ClippedContainer(
      {Key? key,
      required this.size,
      required this.percent,
      required this.valueBack})
      : super(key: key);
  final Size size;
  final double percent, valueBack;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: (-size.width * percent).clamp(0, 0.35),
      child: SizedBox(
        height: size.height * .12,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(painter: CuttingClipper()),
            Positioned(
              right: 100,
              bottom: 20,
              child: Text(
                travels[2].title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
