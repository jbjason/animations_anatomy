import 'package:animations_anatomy/models/superhero.dart';
import 'package:flutter/material.dart';

class SuperHeroCardAndImages extends StatelessWidget {
  const SuperHeroCardAndImages(
      {Key? key,
      required this.superhero,
      required this.firstAnim,
      required this.secondAnim,
      required this.thirdAnim,
      required this.factorChange})
      : super(key: key);
  final Superhero superhero;
  final double factorChange;
  final Animation<double> firstAnim, secondAnim, thirdAnim;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final separation = size.height * .35;
    return AnimatedBuilder(
      animation: Listenable.merge([firstAnim, secondAnim, thirdAnim]),
      builder: (context, _) {
        return OverflowBox(
          maxHeight: size.height,
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              // Background Card
              Positioned(
                top: separation * (1 - firstAnim.value) -
                    (size.height * thirdAnim.value),
                left: 0,
                right: 0,
                height: size.height,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(superhero.rawColor),
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50 * (1 - firstAnim.value))),
                  ),
                ),
              ),
              // superHero Main Image
              Positioned(
                top: separation * factorChange,
                left: 20,
                right: 20,
                bottom:
                    (size.height * .2) + (size.height * .3) * secondAnim.value,
                child: Opacity(
                  opacity: 1 - factorChange,
                  child: Image.asset(superhero.pathImage),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
