import 'package:flutter/material.dart';

class BatmanLogoAnim extends StatelessWidget {
  const BatmanLogoAnim(
      {Key? key, required this.animation1, required this.animation2})
      : super(key: key);
  final Animation<double> animation1, animation2;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([animation1, animation2]),
      builder: (context, _) => Transform.translate(
        offset: Offset(0, 100 * (1 - animation2.value)),
        child: Transform.scale(
          scale: animation1.value,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    blurRadius: 15,
                    spreadRadius: 5,
                    offset: const Offset(1, 1))
              ],
            ),
            child: Image.asset('assets/batman_/batman_logo.png',
                fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
