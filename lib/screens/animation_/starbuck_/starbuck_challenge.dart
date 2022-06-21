import 'dart:ui';

import 'package:animations_anatomy/models/drink.dart';
import 'package:animations_anatomy/screens/animation_/starbuck_/starbuck_home.dart';
import 'package:flutter/material.dart';

class StarbuckChallenge extends StatefulWidget {
  const StarbuckChallenge({Key? key}) : super(key: key);
  @override
  State<StarbuckChallenge> createState() => _StarbuckChallengeState();
}

class _StarbuckChallengeState extends State<StarbuckChallenge> {
  late final PageController _controller;
  double _value = 0.0;

  @override
  void initState() {
    _controller = PageController(initialPage: 0, viewportFraction: 0.9);
    _controller.addListener(_listen);
    super.initState();
  }

  void _listen() => setState(() => _value = _controller.page!);

  @override
  void dispose() {
    _controller.removeListener(_listen);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _appBar(),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemBuilder: (context, index) {
                  final _percent = (index - _value).abs();
                  return DrinkItem(
                      drink: drinkList[index], size: _size, percent: _percent);
                },
                itemCount: drinkList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar() => Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/starbuck/location.png', height: 30),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                        transitionDuration: const Duration(seconds: 2),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            StarbuckHome(animation: animation)),
                  );
                },
                child: Image.asset('assets/starbuck/logo.png')),
            Image.asset('assets/starbuck/drawer.png', height: 30),
          ],
        ),
      );
}

class DrinkItem extends StatelessWidget {
  const DrinkItem(
      {Key? key,
      required this.percent,
      required this.size,
      required this.drink})
      : super(key: key);
  final Drink drink;
  final Size size;
  final double percent;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                _title(),
                const SizedBox(height: 30),
                Expanded(child: _column()),
                const SizedBox(height: 70),
              ],
            ),
          ),
          _containerBody(),
        ],
      ),
    );
  }

  Widget _containerBody() => Stack(
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
            left: lerpDouble(size.width * 0.15, size.width * 0.6, percent),
            top: 75,
            child: Image.asset(drink.imageTop,
                fit: BoxFit.cover, height: 60, width: 60),
          ),
          // rightCenter smallImage
          Positioned(
            right: lerpDouble(-10, 80, percent),
            top: size.height * .37,
            child: Image.asset(drink.imageSmall,
                fit: BoxFit.cover, height: 60, width: 60),
          ),
          // bottom smallImage
          Positioned(
            bottom: 20,
            left: lerpDouble(size.width * .22, size.width * .01, percent),
            child: Image.asset(drink.imageBlur,
                fit: BoxFit.cover, height: 90, width: 90),
          ),
        ],
      );
  Widget _column() => Container(
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage(drink.backgroundImage), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            const Text(
              'Frappuccino',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
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
              child: RichText(
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
            ),
            const SizedBox(height: 30),
          ],
        ),
      );
  Widget _title() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Text(
              drink.name,
              style: TextStyle(
                  color: drink.lightColor,
                  fontSize: 34,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              drink.conName,
              style: TextStyle(
                  color: drink.darkColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
