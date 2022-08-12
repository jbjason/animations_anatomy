import 'package:flutter/material.dart';

class AnimCharacters extends StatelessWidget {
  const AnimCharacters({Key? key, required this.style, required this.text})
      : super(key: key);
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    List<String> characters = text.split('');
    return ClipRect(
      child: Row(
        children: [
          ...characters.asMap().entries.map(
            (char) {
              return FutureBuilder(
                future: Future.delayed(Duration(milliseconds: char.key * 100)),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  }
                  return TweenAnimationBuilder(
                    tween: Tween<double>(begin: 30, end: 0),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, double val, chil) {
                      return Transform.translate(
                        offset: Offset(0, val),
                        child: chil,
                      );
                    },
                    child: Text(char.value, style: style),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
