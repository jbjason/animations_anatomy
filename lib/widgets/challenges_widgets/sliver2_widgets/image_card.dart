import 'package:animations_anatomy/models/travel.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  const ImageCard(
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
