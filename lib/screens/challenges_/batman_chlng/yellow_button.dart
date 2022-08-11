import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class YellowButton extends StatelessWidget {
  const YellowButton({Key? key, required this.onpress, required this.text})
      : super(key: key);
  final VoidCallback onpress;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onpress,
        child: Container(
          height: 55,
          color: const Color(0xFFFDE86A),
          child: Stack(
            children: [
              Center(
                child: Text(
                  text,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              if (text == 'LOGIN')
                Positioned(
                  right: 5,
                  child: Transform.rotate(
                    angle: vector.radians(-40),
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'assets/batman_/batman_logo.png',
                      height: 30,
                      width: 60,
                      color: Colors.black26,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              if (text != 'LOGIN')
                Positioned(
                  left: 5,
                  child: Transform.rotate(
                    angle: vector.radians(40),
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      'assets/batman_/batman_logo.png',
                      height: 30,
                      width: 60,
                      color: Colors.black26,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
