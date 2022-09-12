import 'package:flutter/material.dart';

class Bank1Button extends StatelessWidget {
  const Bank1Button(
      {Key? key,
      required this.text,
      this.isChosen = false,
      this.isPill = false})
      : super(key: key);
  final bool isChosen;
  final bool isPill;
  final String text;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final squareSideLength = width / 5;
    final buttonWidth = squareSideLength * (isPill ? 2.16 : 1);
    final buttonSize = Size(buttonWidth, squareSideLength);
    final outerShadow = BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(46, 46, 46, 1)),
      borderRadius: BorderRadius.circular(buttonSize.width),
      color: const Color.fromRGBO(38, 38, 38, 1),
      boxShadow: const [
        BoxShadow(
          blurRadius: 15,
          offset: Offset(4.5, 4.5),
          color: Color.fromRGBO(12, 12, 12, 1),
        ),
        BoxShadow(
          blurRadius: 15,
          offset: Offset(2, 2),
          color: Colors.white12,
        )
      ],
    );

    return SizedBox(
      height: buttonSize.height,
      width: buttonSize.width,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 50),
            padding: EdgeInsets.all(width / 12),
            decoration: outerShadow,
          ),
          Align(
            alignment: Alignment(isPill ? -0.6 : 0, 0),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w300,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
