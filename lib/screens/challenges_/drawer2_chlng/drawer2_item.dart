import 'package:animations_anatomy/screens/challenges_/drawer2_chlng/anim_characters.dart';
import 'package:flutter/material.dart';

class Drawer2Item extends StatelessWidget {
  const Drawer2Item({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Row(
        children: [
          const Text('-', style: TextStyle(fontSize: 30, color: Colors.white)),
          const SizedBox(width: 30),
          AnimCharacters(
            style: const TextStyle(
                fontSize: 25, color: Colors.white, letterSpacing: 1.4),
            text: text,
          )
        ],
      ),
    );
  }
}
