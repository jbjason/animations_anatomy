import 'package:animations_anatomy/models/superhero.dart';
import 'package:flutter/material.dart';

class SuperHeroTitleAndText extends StatelessWidget {
  const SuperHeroTitleAndText(
      {Key? key,
      required this.animation,
      required this.titleColorAnim,
      required this.hero})
      : super(key: key);
  final Superhero hero;
  final Animation<double> animation;
  final Animation<Color?> titleColorAnim;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: Listenable.merge([animation, titleColorAnim]),
      builder: (context, _) => Stack(
        children: [
          Positioned(
            bottom: size.height * .15 + (size.height * .2) * animation.value,
            left: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(hero.heroName,
                    style: TextStyle(
                        color: titleColorAnim.value,
                        fontWeight: FontWeight.w800,
                        fontSize: 45,
                        letterSpacing: 1.7)),
                Text(hero.name,
                    style:
                        TextStyle(color: titleColorAnim.value, fontSize: 20)),
                const SizedBox(height: 20),
                // learn more button
                Opacity(
                  opacity: 1 - animation.value.clamp(0.0, 1),
                  child: const Text.rich(
                    TextSpan(
                      text: 'learn more',
                      style: TextStyle(color: Colors.yellow),
                      children: [
                        WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(Icons.arrow_right_alt,
                                color: Colors.yellow))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
