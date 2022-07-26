import 'dart:math';

import 'package:animations_anatomy/models/superhero.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/superhero_widgets/superhero_card_and_images.dart';
import 'package:flutter/material.dart';

class SuperHeroHomeBody extends StatelessWidget {
  const SuperHeroHomeBody(
      {Key? key,
      required this.auxPercent,
      required this.heroes,
      required this.auxIndex,
      required this.percent,
      required this.index,
      required this.thirdAnim,
      required this.firstAnim,
      required this.secondAnim})
      : super(key: key);

  final double auxPercent;
  final List<Superhero> heroes;
  final int auxIndex;
  final double percent;
  final int index;
  final Animation<double> firstAnim, secondAnim, thirdAnim;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // next SuperHero
        AnimatedBuilder(
          animation: firstAnim,
          builder: (context, _) => Transform.translate(
            offset: Offset(0, 100 * auxPercent * (1 - firstAnim.value)),
            child: SuperHeroCardAndImages(
              superhero: heroes[auxIndex],
              factorChange: auxPercent,
              firstAnim: firstAnim,
              secondAnim: secondAnim,
              thirdAnim: thirdAnim,
            ),
          ),
        ),
        // Front SuperHero
        Transform.rotate(
          angle: (-pi * .5) * percent,
          child: Transform.translate(
            offset: Offset(-800 * percent, -50 * percent),
            child: SuperHeroCardAndImages(
              superhero: heroes[index],
              factorChange: percent,
              firstAnim: firstAnim,
              secondAnim: secondAnim,
              thirdAnim: thirdAnim,
            ),
          ),
        ),
      ],
    );
  }
}
