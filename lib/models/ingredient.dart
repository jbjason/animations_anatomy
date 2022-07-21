import 'package:flutter/cupertino.dart';

class Ingradient {
  final String image, imageUnit;
  final List<Offset> positions;

  const Ingradient(
      {required this.image, required this.imageUnit, required this.positions});
}

const ingradients = [
  Ingradient(
      image: 'assets/pizza_/chili.png',
      imageUnit: 'assets/pizza_/chili_unit.png',
      positions: [
        Offset(.3, .5),
        Offset(.23, .2),
        Offset(.4, .25),
        Offset(.5, .3),
        Offset(.4, .65),
      ]),
  Ingradient(
      image: 'assets/pizza_/garlic.png',
      imageUnit: 'assets/pizza_/garlic_unit.png',
      positions: [
        Offset(.2, .35),
        Offset(.65, .35),
        Offset(.3, .23),
        Offset(.5, .2),
        Offset(.3, .5),
      ]),
  Ingradient(
      image: 'assets/pizza_/olive.png',
      imageUnit: 'assets/pizza_/olive_unit.png',
      positions: [
        Offset(.25, .5),
        Offset(.65, .6),
        Offset(.2, .3),
        Offset(.4, .2),
        Offset(.2, .6),
      ]),
  Ingradient(
      image: 'assets/pizza_/pea.png',
      imageUnit: 'assets/pizza_/pea_unit.png',
      positions: [
        Offset(.2, .65),
        Offset(.65, .3),
        Offset(.25, .25),
        Offset(.45, .35),
        Offset(.4, .65),
      ]),
  Ingradient(
      image: 'assets/pizza_/pickle.png',
      imageUnit: 'assets/pizza_/pickle_unit.png',
      positions: [
        Offset(.2, .35),
        Offset(.65, .35),
        Offset(.3, .23),
        Offset(.5, .2),
        Offset(.3, .5),
      ]),
  Ingradient(
      image: 'assets/pizza_/onion.png',
      imageUnit: 'assets/pizza_/onion.png',
      positions: [
        Offset(.2, .65),
        Offset(.65, .3),
        Offset(.25, .25),
        Offset(.45, .35),
        Offset(.65, .6),
      ]),
  Ingradient(
      image: 'assets/pizza_/potato.png',
      imageUnit: 'assets/pizza_/potato_unit.png',
      positions: [
        Offset(.55, .5),
        Offset(.6, .2),
        Offset(.4, .25),
        Offset(.5, .3),
        Offset(.4, .65),
      ]),
];
