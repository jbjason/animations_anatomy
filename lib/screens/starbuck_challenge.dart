import 'package:flutter/material.dart';

Color mBrown = const Color(0xff81554E);
Color mBrownLight = const Color(0xffC09C88);
Color greenLight = const Color(0xffA3DB72);
Color greenDark = const Color(0xff497E19);
Color mAppGreen = const Color(0xff067655);
Color mToGreen = const Color(0xff033B2B);

class Drink {
  String name;
  String conName;
  String backgroundImage;
  String imageTop;
  String imageSmall;
  String imageBlur;
  String cupImage;
  String description;
  Color lightColor;
  Color darkColor;

  Drink(
    this.name,
    this.conName,
    this.backgroundImage,
    this.imageTop,
    this.imageSmall,
    this.imageBlur,
    this.cupImage,
    this.description,
    this.lightColor,
    this.darkColor,
  );
}

List<Drink> drinkList = [
  Drink(
      'Tirami',
      'Sù',
      'images/blur_image.png',
      'images/bean_top.png',
      'images/bean_small.png',
      'images/bean_blur.png',
      'images/cup.png',
      'then top with whipped cream and mocha drizzle to bring you endless \njava joy',
      mBrownLight,
      mBrown),
  Drink(
      'Green',
      'Tea',
      'images/green_image.png',
      'images/green_top.png',
      'images/green_small.png',
      'images/green_blur.png',
      'images/green_tea_cup.png',
      'milk and ice and top it with sweetened whipped cream to give you \na delicious boost\nof energy.',
      greenLight,
      greenDark),
  Drink(
      'Triple',
      'Mocha',
      'images/mocha_image.png',
      'images/chocolate_top.png',
      'images/chocolate_small.png',
      'images/chocolate_blur.png',
      'images/mocha_cup.png',
      'layers of whipped cream that’s infused with cold brew, white chocolate mocha and dark \ncaramel.',
      mBrownLight,
      mBrown)
];
