import 'package:animations_anatomy/models/coffee_card.dart';
import 'package:flutter/material.dart';

class CoffeeChlngScreen extends StatefulWidget {
  const CoffeeChlngScreen({Key? key}) : super(key: key);
  @override
  State<CoffeeChlngScreen> createState() => _CoffeeChlngScreenState();
}

const _initialIndex = 0;
const _duration = Duration(milliseconds: 250);

class _CoffeeChlngScreenState extends State<CoffeeChlngScreen> {
  late PageController _imageController;
  late PageController _textController;
  double _currentPage = 0.0;

  @override
  void initState() {
    _imageController =
        PageController(viewportFraction: 0.35, initialPage: _initialIndex);
    _textController = PageController(initialPage: _initialIndex);
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
    _textController.dispose();
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
          bottomBrownShadow(size),
          coffeImages(size),
          titleAndPrice(),
        ],
      ),
    );
  }

  Widget coffeImages(Size size) => Transform.scale(
        scale: 1.6,
        alignment: Alignment.bottomCenter,
        child: PageView.builder(
          controller: _imageController,
          scrollDirection: Axis.vertical,
          onPageChanged: (_val) {
            if (_val < coffeeCards.length) {
              _textController.animateToPage(_val,
                  duration: _duration, curve: Curves.easeOut);
            }
          },
          itemCount: coffeeCards.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const SizedBox.shrink();
            }
            final coffee = coffeeCards[index - 1];
            final result = _currentPage - index + 1;
            final value = -0.4 * result + 1;
            final opacity = value.clamp(0.0, 1.0);
            return Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Transform(
                alignment: Alignment.bottomCenter,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, .001)
                  ..translate(0.0, size.height / 2.9 * (1 - value).abs())
                  ..scale(value),
                child: Opacity(
                  opacity: opacity,
                  child: Image.asset(coffee.image, fit: BoxFit.fitHeight),
                ),
              ),
            );
          },
        ),
      );

  Widget titleAndPrice() {
    final CoffeeCard _coffee;
    if (coffeeCards.length > _currentPage.toInt()) {
      _coffee = coffeeCards[_currentPage.toInt()];
    } else {
      _coffee = coffeeCards[_currentPage.toInt() - 1];
    }
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _textController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: coffeeCards.length,
              itemBuilder: (context, index) {
                final _opacity = 1 - (_currentPage - index).clamp(0.0, 1.0);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Opacity(
                    opacity: _opacity,
                    child: Text(
                      coffeeCards[index].name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          AnimatedSwitcher(
            duration: _duration,
            key: Key(_coffee.name),
            child: Text(
              '${_coffee.price.toStringAsFixed(2)}€',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomBrownShadow(Size size) => Positioned(
        left: 20,
        right: 20,
        bottom: -size.height * .2,
        height: size.height * .3,
        child: const DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.brown, blurRadius: 90, spreadRadius: 60)
            ],
          ),
        ),
      );
}
