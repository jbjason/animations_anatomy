import 'package:flutter/material.dart';

class PickSkin {
  final String name, image;
  final Color skincolor;
  final Alignment skinAlign;

  const PickSkin(
      {required this.skinAlign,
      required this.name,
      required this.image,
      required this.skincolor});
}

final skins = [
  const PickSkin(
      name: 'Paint 1',
      image: 'assets/card_/4.jpg',
      skinAlign: Alignment.center,
      skincolor: Colors.blue),
  const PickSkin(
      name: 'Paint 2',
      image: 'assets/card_/5.jpg',
      skinAlign: Alignment.topLeft,
      skincolor: Colors.green),
  const PickSkin(
      name: 'Paint 3',
      image: 'assets/card_/7.jpg',
      skinAlign: Alignment.center,
      skincolor: Colors.brown),
  const PickSkin(
      name: 'Paint 4',
      image: 'assets/card_/8.jpg',
      skinAlign: Alignment.centerLeft,
      skincolor: Colors.grey),
  const PickSkin(
      name: 'Paint 5',
      image: 'assets/card_/9.jpg',
      skinAlign: Alignment.centerRight,
      skincolor: Colors.amber),
  const PickSkin(
      name: 'Paint 6',
      image: 'assets/card_/10.jpg',
      skinAlign: Alignment.bottomLeft,
      skincolor: Colors.red),
  const PickSkin(
      name: 'Paint 7',
      image: 'assets/card_/12.jpg',
      skinAlign: Alignment.bottomRight,
      skincolor: Colors.orange),
  const PickSkin(
      name: 'Paint 8',
      image: 'assets/card_/13.jpg',
      skinAlign: Alignment.topRight,
      skincolor: Colors.purple),
];
