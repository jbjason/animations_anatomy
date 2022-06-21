import 'package:flutter/material.dart';

Color mBrown = const Color(0xff81554E);
Color mBrownLight = const Color(0xffC09C88);
Color greenLight = const Color(0xffA3DB72);
Color greenDark = const Color(0xff497E19);
Color mAppGreen = const Color(0xff067655);
Color mToGreen = const Color(0xff033B2B);

class Drink {
  final String name;
  final String conName;
  final String backgroundImage;
  final String imageTop;
  final String imageSmall;
  final String imageBlur;
  final String cupImage;
  final String description;
  final Color lightColor;
  final double price;
  final Color darkColor;

  const Drink(
      {required this.name,
      required this.price,
      required this.conName,
      required this.backgroundImage,
      required this.imageTop,
      required this.imageSmall,
      required this.imageBlur,
      required this.cupImage,
      required this.description,
      required this.lightColor,
      required this.darkColor});
}

final List<Drink> drinkList = [
  Drink(
    name: 'Tirami',
    conName: 'Sù',
    price: 4.70,
    backgroundImage: 'images/blur_image.png',
    imageTop: 'images/bean_top.png',
    imageSmall: 'images/bean_small.png',
    imageBlur: 'images/bean_blur.png',
    cupImage: 'images/cup.png',
    description:
        'then top with whipped cream and mocha drizzle to bring you endless \njava joy',
    lightColor: mBrownLight,
    darkColor: mBrown,
  ),
  Drink(
    name: 'Green',
    conName: 'Tea',
    price: 8.50,
    backgroundImage: 'images/green_image.png',
    imageTop: 'images/green_top.png',
    imageSmall: 'images/green_small.png',
    imageBlur: 'images/green_blur.png',
    cupImage: 'images/green_tea_cup.png',
    description:
        'milk and ice and top it with sweetened whipped cream to give you \na delicious boost\nof energy.',
    lightColor: greenLight,
    darkColor: greenDark,
  ),
  Drink(
    name: 'Triple',
    price: 11.70,
    conName: 'Mocha',
    backgroundImage: 'images/mocha_image.png',
    imageTop: 'images/chocolate_top.png',
    imageSmall: 'images/chocolate_small.png',
    imageBlur: 'images/chocolate_blur.png',
    cupImage: 'images/mocha_cup.png',
    description:
        'layers of whipped cream that\'s infused with cold brew, white chocolate mocha and dark \ncaramel.',
    lightColor: mBrownLight,
    darkColor: mBrown,
  ),
];
