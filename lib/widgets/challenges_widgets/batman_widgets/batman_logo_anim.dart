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
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  blurRadius: 50,
                  spreadRadius: 40,
                  //  offset: const Offset(20, -10),
                )
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
