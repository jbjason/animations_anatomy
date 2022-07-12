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
        clipBehavior: Clip.none,
        children: [
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
          CoffeeChlngDetails1(
              size: size, animation: animation, price: coffee.price),
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
      required this.price})
      : super(key: key);
  final Size size;
  final double price;
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
      builder: (context, _) {
        final _val = 1 - widget.animation.value;
        return Stack(
          children: [
            // bottom Flat-buttons
            Positioned(
              bottom: 0,
              left: 10,
              right: 10,
              height: widget.size.height * .15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  textButton('Hot/Warm', () => setState(() => _isHot = true),
                      _isHot ? 1 : 0),
                  textButton('Cold/Ice', () => setState(() => _isHot = false),
                      _isHot ? 0 : 1),
                ],
              ),
            ),
            // price
            Positioned(
              left: 50,
              top: widget.size.height * .5,
              child: Transform.translate(
                offset: Offset(-100 * _val, 100 * _val),
                child: Text(
                  '${widget.price.toStringAsFixed(2)}€',
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    shadows: [
                      BoxShadow(
                          color: Colors.black45,
                          blurRadius: 20,
                          spreadRadius: 30)
                    ],
                  ),
                ),
              ),
            ),
            // top add_icon
            Positioned(
              right: 50,
              top: 100,
              height: 60,
              child: Transform.translate(
                offset: Offset(100 * _val, 0),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          spreadRadius: 2)
                    ],
                  ),
                  child: const Icon(Icons.add, color: Colors.black),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget textButton(String text, Function _onPress, int i) {
    return TextButton(
      onPressed: () => _onPress(),
      style: TextButton.styleFrom(
          primary: i == 1 ? Colors.black : Colors.grey,
          backgroundColor:
              i == 1 ? Colors.white.withOpacity(0.5) : Colors.transparent,
          textStyle: const TextStyle(fontSize: 20),
          elevation: i == 1 ? 20 : 0,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20)),
      child: Text(text),
    );
  }
}
