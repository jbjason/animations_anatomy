import 'package:animations_anatomy/models/coffee_card.dart';
import 'package:flutter/material.dart';

class CoffeeChlngScreen extends StatefulWidget {
  const CoffeeChlngScreen({Key? key}) : super(key: key);
  @override
  State<CoffeeChlngScreen> createState() => _CoffeeChlngScreenState();
}

class _CoffeeChlngScreenState extends State<CoffeeChlngScreen> {
  late PageController _imageController;
  double _currentPage = 0.0;

  @override
  void initState() {
    _imageController = PageController(viewportFraction: 0.35);
    _imageController.addListener(_listener);
    super.initState();
  }

  void _listener() {
    setState(() {
      _currentPage = _imageController.page!;
    });
  }

  @override
  void dispose() {
    _imageController.removeListener(_listener);
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        actions: const [
          Icon(Icons.shopping_basket_sharp, color: Colors.black),
          SizedBox(width: 20)
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: 20,
            right: 20,
            bottom: -size.height * .22,
            height: size.height * .3,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.brown, blurRadius: 90, spreadRadius: 45)
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: size.height * .15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    'Toffee Nut Crunch Latte',
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Text(
                  '3.00€',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 1.6,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
              controller: _imageController,
              scrollDirection: Axis.vertical,
              itemCount: coffeeCards.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const SizedBox.shrink();
                }
                final coffee = coffeeCards[index - 1];
                final result = _currentPage - index + 1;
                final value = -0.45 * result + 1;
                final opacity = value.clamp(0.0, 1.0);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Transform(
                    alignment: Alignment.topCenter,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, .001)
                      ..translate(0.0, (size.height / 1.7) * (1 - value).abs())
                      ..scale(value),
                    child: Opacity(
                      opacity: opacity,
                      child: Image.asset(coffee.image, fit: BoxFit.fitHeight),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
