import 'package:flutter/cupertino.dart';

class Ingradient {
  final String image;
  final List<Offset> positions;

  const Ingradient({required this.image, required this.positions});
}

const ingradients = [
  Ingradient(image: 'assets/pizza_/chili.png', positions: [
    Offset(.2, .2),
    Offset(.6, .2),
    Offset(.4, .25),
    Offset(.5, .3),
    Offset(.4, .65),
  ]),
  Ingradient(image: 'assets/pizza_/garlic.png', positions: [
    Offset(.2, .35),
    Offset(.65, .35),
    Offset(.3, .23),
    Offset(.5, .2),
    Offset(.3, .5),
  ]),
  Ingradient(image: 'assets/pizza_/olive.png', positions: [
    Offset(.25, .5),
    Offset(.65, .6),
    Offset(.2, .3),
    Offset(.4, .2),
    Offset(.2, .6),
  ]),
  Ingradient(image: 'assets/pizza_/pea.png', positions: [
    Offset(.2, .65),
    Offset(.65, .3),
    Offset(.25, .25),
    Offset(.45, .35),
    Offset(.4, .65),
  ]),
  Ingradient(image: 'assets/pizza_/pickle.png', positions: [
    Offset(.2, .35),
    Offset(.65, .35),
    Offset(.3, .23),
    Offset(.5, .2),
    Offset(.3, .5),
  ]),
  Ingradient(image: 'assets/pizza_/onion.png', positions: [
    Offset(.2, .65),
    Offset(.65, .3),
    Offset(.25, .25),
    Offset(.45, .35),
    Offset(.4, .65),
  ]),
  Ingradient(image: 'assets/pizza_/potato.png', positions: [
    Offset(.2, .2),
    Offset(.6, .2),
    Offset(.4, .25),
    Offset(.5, .3),
    Offset(.4, .65),
  ]),
];
