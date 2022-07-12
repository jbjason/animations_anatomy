import 'package:animations_anatomy/models/coffee_card.dart';
import 'package:animations_anatomy/screens/challenges_/coffe_chlng/coffee_chlng_screen.dart';
import 'package:flutter/material.dart';

class CoffeeChlngHome extends StatelessWidget {
  const CoffeeChlngHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 600),
              pageBuilder: (context, animation, _) => FadeTransition(
                opacity: animation,
                child: CoffeeChlngScreen(
                    animation: CurvedAnimation(
                        parent: animation,
                        curve: const Interval(0.3, 1, curve: Curves.easeIn))),
              ),
            ),
          );
        },
        child: Stack(
          children: [
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFA89276), Colors.white]),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              height: size.height * .4,
              top: size.height * .15,
              child: Hero(
                  tag: coffeeCards[6].name,
                  child: Image.asset(coffeeCards[6].image)),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: size.height * .68,
              child: Hero(
                  tag: coffeeCards[7].name,
                  child: Image.asset(coffeeCards[7].image, fit: BoxFit.cover)),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: -size.height * .8,
              height: size.height,
              child: Hero(
                  tag: coffeeCards[8].name,
                  child: Image.asset(coffeeCards[8].image, fit: BoxFit.cover)),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: size.height * .25,
              height: 140,
              child: Image.asset('assets/coffee_/logo.png'),
            ),
          ],
        ),
      ),
    );
  }
}
