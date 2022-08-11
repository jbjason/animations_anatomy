import 'package:flutter/material.dart';

class PriceAndAddButton extends StatelessWidget {
  const PriceAndAddButton(
      {Key? key,
      required this.size,
      required this.animation,
      required this.price})
      : super(key: key);
  final Size size;
  final double price;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final _val = 1 - animation.value;
        return Stack(
          children: [
            // price
            Positioned(
              left: 50,
              top: size.height * .5,
              child: Transform.translate(
                offset: Offset(-100 * _val, 100 * _val),
                child: Text(
                  '${price.toStringAsFixed(2)}€',
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    shadows: [
                      BoxShadow(
                          color: Colors.black45,
                          blurRadius: 20,
                          spreadRadius: 30)
                    ],
                  ),
                ),
              ),
            ),
            // top add_icon
            Positioned(
              right: 50,
              top: 100,
              height: 60,
              child: Transform.translate(
                offset: Offset(100 * _val, 0),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          spreadRadius: 2)
                    ],
                  ),
                  child: const Icon(Icons.add, color: Colors.black),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
