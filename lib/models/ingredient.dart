import 'package:flutter/cupertino.dart';

class Pizza {
  final String name;
  final double price;
  final String image;

  Pizza({required this.name, required this.price, required this.image});
}

class Ingredient {
  final String image, imageUnit;
  final List<Offset> positions;

  const Ingredient(
      {required this.image, required this.imageUnit, required this.positions});
}

enum PizzaSizeValue { S, M, L }

class PizzaSizeState {
  final PizzaSizeValue value;
  final double factor;

  PizzaSizeState({required this.value}) : factor = _getFactorBySize(value);
  static double _getFactorBySize(PizzaSizeValue value) {
    switch (value) {
      case PizzaSizeValue.S:
        return 0.8;
      case PizzaSizeValue.M:
        return 0.9;
      case PizzaSizeValue.L:
        return 1.0;
    }
  }
}

final List<Pizza> pizzaList = [
  Pizza(
      name: 'Neapolitan Pizza',
      price: 8.12,
      image: 'assets/pizza_/pizza-0.png'),
  Pizza(name: 'Chicago Pizza', price: 6.25, image: 'assets/pizza_/pizza-1.png'),
  Pizza(
      name: 'New York-Style Pizza',
      price: 13.0,
      image: 'assets/pizza_/pizza-2.png'),
  Pizza(
      name: 'Sicilian Pizza', price: 15.4, image: 'assets/pizza_/pizza-3.png'),
  Pizza(
      name: 'St. Louis Pizza',
      price: 12.42,
      image: 'assets/pizza_/pizza-4.png'),
  Pizza(
      name: 'Detroit Pizza', price: 10.75, image: 'assets/pizza_/pizza-5.png'),
  Pizza(
      name: 'California Pizza',
      price: 5.50,
      image: 'assets/pizza_/pizza-6.png'),
  Pizza(
      name: 'Neapolitan Pizza',
      price: 12.45,
      image: 'assets/pizza_/pizza-8.png'),
  Pizza(
      name: 'Detroit Pizza2', price: 4.87, image: 'assets/pizza_/pizza-9.png'),
  Pizza(
      name: 'Neapolitan Pizza2',
      price: 10.78,
      image: 'assets/pizza_/pizza-10.png'),
];
const ingredients = [
  Ingredient(
      image: 'assets/pizza_/chili.png',
      imageUnit: 'assets/pizza_/chili_unit.png',
      positions: [
        Offset(.3, .5),
        Offset(.23, .2),
        Offset(.4, .25),
        Offset(.5, .3),
        Offset(.4, .65),
      ]),
  Ingredient(
      image: 'assets/pizza_/garlic.png',
      imageUnit: 'assets/pizza_/garlic_unit.png',
      positions: [
        Offset(.2, .35),
        Offset(.65, .35),
        Offset(.3, .23),
        Offset(.5, .2),
        Offset(.3, .5),
      ]),
  Ingredient(
      image: 'assets/pizza_/olive.png',
      imageUnit: 'assets/pizza_/olive_unit.png',
      positions: [
        Offset(.25, .5),
        Offset(.65, .6),
        Offset(.2, .3),
        Offset(.4, .2),
        Offset(.2, .6),
      ]),
  Ingredient(
      image: 'assets/pizza_/pea.png',
      imageUnit: 'assets/pizza_/pea_unit.png',
      positions: [
        Offset(.2, .65),
        Offset(.65, .3),
        Offset(.25, .25),
        Offset(.45, .35),
        Offset(.4, .65),
      ]),
  Ingredient(
      image: 'assets/pizza_/pickle.png',
      imageUnit: 'assets/pizza_/pickle_unit.png',
      positions: [
        Offset(.35, .2),
        Offset(.35, .65),
        Offset(.23, .3),
        Offset(.53, .2),
        Offset(.4, .5),
      ]),
  Ingredient(
      image: 'assets/pizza_/onion.png',
      imageUnit: 'assets/pizza_/onion.png',
      positions: [
        Offset(.2, .65),
        Offset(.65, .3),
        Offset(.25, .25),
        Offset(.45, .35),
        Offset(.65, .6),
      ]),
  Ingredient(
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
