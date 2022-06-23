import 'dart:ui';
import 'package:animations_anatomy/models/drink.dart';
import 'package:animations_anatomy/screens/animation_/starbuck_/starbuck_challenge.dart';
import 'package:flutter/material.dart';

class StarbuckDetails extends StatelessWidget {
  const StarbuckDetails(
      {Key? key, required this.drink, required this.animation})
      : super(key: key);
  final Drink drink;
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StarbuckAppBar(height: _size.height * .1),
            Expanded(
              child: AnimatedBuilder(
                animation: animation,
                builder: (context, child_) {
                  return DrinkItemAnimated(
                      animation: animation, size: _size, drink: drink);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrinkItemAnimated extends StatelessWidget {
  const DrinkItemAnimated(
      {Key? key,
      required this.animation,
      required this.size,
      required this.drink})
      : super(key: key);
  final Drink drink;
  final Size size;
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    final _value = animation.value;
    return GestureDetector(
      onVerticalDragUpdate: (val) {
        if (val.delta.dy > 10) {
          Navigator.pop(context);
        }
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              width: lerpDouble(size.width * .78, size.width, _value),
              margin: EdgeInsets.only(
                bottom: lerpDouble(70, 0, _value)!,
                top: lerpDouble(size.height * .1, 20, _value)!,
              ),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: const Radius.circular(40),
                  bottom: Radius.circular(lerpDouble(40, 0, _value)!),
                ),
                image: DecorationImage(
                    image: AssetImage(drink.backgroundImage),
                    fit: BoxFit.cover),
              ),
              child: Column(
                children: [
                  SizedBox(height: lerpDouble(30, size.height * .1, _value)),
                  Expanded(child: _column()),
                ],
              ),
            ),
          ),
          _containerBody(_value),
          Positioned(top: 0, child: _title(_value)),
        ],
      ),
    );
  }

  Widget _containerBody(double _value) => Stack(
        clipBehavior: Clip.none,
        children: [
          // cup image
          Positioned(
            right: -20,
            bottom: 10,
            child: Image.asset(drink.cupImage,
                fit: BoxFit.cover, height: size.height * .55),
          ),
          // top smallImage
          Positioned(
            left: lerpDouble(size.width * 0.3, size.width * 0.85, _value),
            top: 75,
            child: Image.asset(drink.imageTop,
                fit: BoxFit.cover, height: 45, width: 45),
          ),
          // rightCenter smallImage
          Positioned(
            right: lerpDouble(-10, 100, _value),
            top: lerpDouble(size.height * .45, size.height * .19, _value),
            child: Image.asset(drink.imageSmall,
                fit: BoxFit.cover, height: 40, width: 40),
          ),
          // bottom smallImage
          Positioned(
            bottom: lerpDouble(25, size.height * .7, _value),
            left: lerpDouble(size.width * .01, 40, _value),
            child: Image.asset(drink.imageBlur,
                fit: BoxFit.cover, height: 75, width: 75),
          ),
        ],
      );
  Widget _column() => Column(
        children: [
          const Text(
            'Frappuccino',
            style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Text(
            drink.description,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: TextStyle(color: Colors.white.withOpacity(0.6)),
          ),
          const Spacer(),
          Container(
            height: 60,
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(width: 20),
                Image.asset('assets/starbuck/cup_L.png', height: 40),
                const SizedBox(width: 7),
                Image.asset('assets/starbuck/cup_M.png', height: 30),
                const SizedBox(width: 7),
                Image.asset('assets/starbuck/cup_s.png', height: 20),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
              height: 60,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: LinearGradient(
                  colors: [mAppGreen, mToGreen],
                  stops: const [0.2, 1.0],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: '\$ ',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 27),
                      children: [
                        TextSpan(
                          text: '${drink.price.toInt()}.',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        TextSpan(
                          text: drink.price.toString().split('.')[1],
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Order',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              )),
          const SizedBox(height: 30),
        ],
      );
  Widget _title(double val) {
    final _font = lerpDouble(45, 20, val)!;
    return Container(
      height: size.height * .1,
      padding: EdgeInsets.only(
        top: 20.0,
        left: lerpDouble(20 + size.width * .11, 20.0, val)!,
      ),
      child: Row(
        children: [
          Text(
            drink.name,
            style: TextStyle(
                color: drink.lightColor,
                fontSize: _font,
                fontWeight: FontWeight.bold),
          ),
          Text(
            drink.conName,
            style: TextStyle(
                color: drink.darkColor,
                fontSize: _font,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
