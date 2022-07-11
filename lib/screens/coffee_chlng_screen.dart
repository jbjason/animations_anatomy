import 'package:animations_anatomy/models/coffee_card.dart';
import 'package:flutter/material.dart';

class CoffeeChlngScreen extends StatefulWidget {
  const CoffeeChlngScreen({Key? key}) : super(key: key);
  @override
  State<CoffeeChlngScreen> createState() => _CoffeeChlngScreenState();
}

const _initialIndex = 8;
const _duration = Duration(milliseconds: 250);

class _CoffeeChlngScreenState extends State<CoffeeChlngScreen> {
  late PageController _imageController;
  late PageController _textController;
  double _currentPage = _initialIndex.toDouble();
  double _currentTextPage = _initialIndex.toDouble();

  @override
  void initState() {
    _imageController =
        PageController(viewportFraction: 0.35, initialPage: _initialIndex);
    _textController = PageController(initialPage: _initialIndex);
    _imageController.addListener(_listener);
    _textController.addListener(_textListener);
    super.initState();
  }

  void _listener() => setState(() => _currentPage = _imageController.page!);

  void _textListener() => _currentTextPage = _textController.page!;

  @override
  void dispose() {
    _imageController.removeListener(_listener);
    _textController.removeListener(_textListener);
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
        leading: const BackButton(color: Colors.black),
        actions: const [
          Icon(Icons.shopping_basket_sharp, color: Colors.black),
          SizedBox(width: 20)
        ],
      ),
      body: Stack(
        children: [
          bottomBrownShadow(size),
          coffeImages(size),
          titleAndPrice(size),
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
                  child: Hero(
                    tag: coffee.name,
                    child: Image.asset(coffee.image, fit: BoxFit.fitHeight),
                  ),
                ),
              ),
            );
          },
        ),
      );

  Widget titleAndPrice(Size size) => Positioned(
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
                  final _opacity =
                      1 - (_currentTextPage - index).clamp(0.0, 1.0);
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .2),
                    child: Opacity(
                      opacity: _opacity,
                      child: Text(
                        coffeeCards[index].name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                  );
                },
              ),
            ),
            AnimatedSwitcher(
              duration: _duration,
              key: Key(coffeeCards[_currentTextPage.toInt()].name),
              child: Text(
                '${coffeeCards[_currentTextPage.toInt()].price.toStringAsFixed(2)}€',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
          ],
        ),
      );

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
