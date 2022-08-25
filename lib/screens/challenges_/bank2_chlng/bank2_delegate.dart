import 'package:flutter/material.dart';

const _maxHeader = 55.0;
typedef OnHeaderChange = void Function(bool visible);

class Bank2Delegate extends SliverPersistentHeaderDelegate {
  const Bank2Delegate(this.title, this.onHeaderChange);
  final String title;
  final OnHeaderChange onHeaderChange;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (shrinkOffset > 0) {
      onHeaderChange(true);
    } else {
      onHeaderChange(false);
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  double get maxExtent => _maxHeader;

  @override
  double get minExtent => _maxHeader;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
