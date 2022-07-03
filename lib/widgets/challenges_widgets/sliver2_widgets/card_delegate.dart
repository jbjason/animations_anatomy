import 'package:animations_anatomy/models/travel.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/sliver2_widgets/clipped_container.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/sliver2_widgets/image_card.dart';
import 'package:flutter/material.dart';

class CardDelegate extends SliverPersistentHeaderDelegate {
  const CardDelegate(
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
        ClippedContainer(size: size, percent: percent, valueBack: valueBack);
    final _imageCard = ImageCard(
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
