import 'package:animations_anatomy/models/coffee_card.dart';
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
        children: [
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            height: size.height * .7,
            child: Column(
              children: [
                Expanded(
                  child: Hero(
                    tag: coffee.name,
                    child: Image.asset(coffee.image,
                        height: size.height * .6, fit: BoxFit.fitHeight),
                  ),
                ),
                const SizedBox(height: 80),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset('assets/coffee_/taza_s.png',
                          height: 60, fit: BoxFit.contain),
                      Image.asset('assets/coffee_/taza_m.png',
                          height: 80, fit: BoxFit.contain),
                      Image.asset('assets/coffee_/taza_l.png',
                          height: 110, fit: BoxFit.contain),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
        ],
      ),
    );
  }
}

class CoffeeChlngDetails1 extends StatefulWidget {
  const CoffeeChlngDetails1(
      {Key? key,
      required this.size,
      required this.animation,
      required this.text})
      : super(key: key);
  final Size size;
  final String text;
  final Animation<double> animation;
  @override
  State<CoffeeChlngDetails1> createState() => _CoffeeChlngDetails1State();
}

class _CoffeeChlngDetails1State extends State<CoffeeChlngDetails1> {
  bool _isHot = true;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animation,
      builder: (context, _) => Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: widget.size.height * .2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  textButton('Hot/Warm', () => setState(() => _isHot = true),
                      _isHot ? 1 : 0),
                  textButton('Cold/Ice', () => setState(() => _isHot = false),
                      _isHot ? 0 : 1),
                ],
              ),
            ),
          ),
          Positioned(
            left: 50,
            top: widget.size.height * .57,
            child: Transform.translate(
              offset: Offset(
                  -100 * widget.animation.value, 240 * widget.animation.value),
              child: Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  shadows: [
                    BoxShadow(
                        color: Colors.black45, blurRadius: 10, spreadRadius: 20)
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 50,
            top: 120,
            height: 90,
            child: Transform.translate(
              offset: Offset(100 * widget.animation.value, 0),
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black45, blurRadius: 10, spreadRadius: 20)
                  ],
                ),
                child: const Icon(Icons.add, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textButton(String text, Function _onPress, int i) {
    return TextButton(
      onPressed: () => _onPress,
      style: TextButton.styleFrom(
        primary: i == 1 ? Colors.black : Colors.grey,
        textStyle: const TextStyle(fontSize: 20),
        elevation: i == 1 ? 20 : 0,
      ),
      child: Text(text),
    );
  }
}
