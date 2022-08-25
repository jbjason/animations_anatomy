import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;

const _appBarHeight = 250.0;

class Bank2AppBar extends StatelessWidget {
  const Bank2AppBar({Key? key, required this.value}) : super(key: key);
  final double value;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: const Text('\$ 135.5 ', style: TextStyle(fontSize: 20)),
      expandedHeight: _appBarHeight,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Center(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 40, left: 20, bottom: 10),
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                final _color = Colors.accents[index % Colors.accents.length];
                const space = _appBarHeight - 60;
                final percent = (value / space).clamp(0.0, 1.0);
                final _rotate = lerpDouble(0.0, -(math.pi / 2), percent);
                return Opacity(
                  opacity: 1 - percent,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, .002)
                      ..rotateX(_rotate!),
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        gradient: LinearGradient(colors: [
                          _color.withOpacity(0.4),
                          _color.withOpacity(0.7),
                          _color,
                        ]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
