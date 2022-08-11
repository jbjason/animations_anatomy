import 'package:animations_anatomy/models/coffee_card.dart';
import 'package:animations_anatomy/screens/challenges_/coffe_chlng/hot_and_ice_buttons.dart';
import 'package:animations_anatomy/screens/challenges_/coffe_chlng/price_and_add_button.dart';
import 'package:flutter/material.dart';

class CoffeeChlngDetails extends StatelessWidget {
  const CoffeeChlngDetails(
      {Key? key, required this.coffee, required this.animation})
      : super(key: key);
  final CoffeeCard coffee;
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: const [
          Icon(Icons.shopping_basket_sharp, color: Colors.black),
          SizedBox(width: 20)
        ],
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          HotAndIceButtons(size: size),
          // image & sized images
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            height: size.height * .7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Hero(
                    tag: coffee.name,
                    child: Image.asset(coffee.image, fit: BoxFit.fitHeight),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset('assets/coffee_/taza_s.png',
                          height: 60, width: 60, fit: BoxFit.contain),
                      Image.asset('assets/coffee_/taza_m.png',
                          height: 80, width: 60, fit: BoxFit.contain),
                      Image.asset('assets/coffee_/taza_l.png',
                          height: 110, width: 60, fit: BoxFit.contain),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // coffee name
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 80,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .2),
              child: Hero(
                tag: 'text${coffee.name}',
                child: Material(
                  child: Text(
                    coffee.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          // price ,ice/hot buttons ,add button
          PriceAndAddButton(
              size: size, animation: animation, price: coffee.price),
        ],
      ),
    );
  }
}
