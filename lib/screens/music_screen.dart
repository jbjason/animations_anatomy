import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class MusicScreen extends StatelessWidget {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300]!,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(delegate: CustomHeader()),
        ],
      ),
    );
  }
}

const double maxHeight = 300, minHeight = 100;

class CustomHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = MediaQuery.of(context).size;
    final percent = 1 - (shrinkOffset / maxExtent);
    final double _boxHeight = (170 * percent).clamp(40, 170);
    final double _discHeight = (140 * percent).clamp(10, 140);
    final double _titleHeight = (22 * percent).clamp(16, 22);
    final double _subHeight = (16 * percent).clamp(13, 16);
    return Container(
      color: Colors.grey[300],
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: size.width / 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dexter Gordon',
                    style: TextStyle(
                        fontSize: _titleHeight, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text('Our Man in Paris',
                    style: TextStyle(fontSize: _subHeight, color: Colors.grey)),
              ],
            ),
          ),
          Positioned(
              bottom: 25,
              left: 20,
              height: _discHeight,
              child: Transform.rotate(
                  angle: vector.radians(360 * percent),
                  child: Image.asset('assets/disk_.png', fit: BoxFit.cover))),
          Positioned(
              bottom: 20,
              left: 20,
              height: _boxHeight,
              child: Image.asset('assets/beach.png', fit: BoxFit.cover))
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxExtent;

  @override
  double get minExtent => minExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
