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
          Container(
            margin: const EdgeInsets.only(top: 20),
            height:
                lerpDouble(size.height * .8, size.height * .4, animation.value),
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: const Radius.circular(40),
                bottom: Radius.circular(lerpDouble(40, 0, _value)!),
              ),
              image: DecorationImage(
                  image: AssetImage(drink.backgroundImage), fit: BoxFit.cover),
            ),
          ),
          // body
          Positioned.fill(
            child: Container(
                width: lerpDouble(size.width * .76, size.width, _value),
                margin: EdgeInsets.only(
                  bottom: lerpDouble(70, 0, _value)!,
                  top: lerpDouble(size.height * .1, 20, _value)!,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: const Radius.circular(40),
                    bottom: Radius.circular(lerpDouble(40, 0, _value)!),
                  ),
                ),
                child: _body(_value)),
          ),
          // small images
          _smallImages(_value),
          // Outside Top title
          Positioned(top: 20, child: _title(_value)),
        ],
      ),
    );
  }

  Widget _smallImages(double _value) {
    final _bottomImg = lerpDouble(75, 50, _value);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // cup image
        Positioned(
          right: -20,
          bottom: 10,
          child: Transform.translate(
            offset: Offset(
                -(size.width * 1 / 4) * _value, size.height * .3 * _value),
            child: Image.asset(drink.cupImage,
                fit: BoxFit.cover, height: size.height * .55),
          ),
        ),
        // top smallImage
        Positioned(
          left: lerpDouble(size.width * 0.3, size.width * 0.85, _value),
          top: 80,
          child: Image.asset(drink.imageTop,
              fit: BoxFit.cover, height: 45, width: 45),
        ),
        // rightCenter smallImage
        Positioned(
          right: lerpDouble(-7, 100, _value),
          top: lerpDouble(size.height * .45, size.height * .19, _value),
          child: Image.asset(drink.imageSmall,
              fit: BoxFit.cover, height: 40, width: 40),
        ),
        // bottom smallImage
        Positioned(
          bottom: lerpDouble(25, size.height * .65, _value),
          left: lerpDouble(size.width * .2, 2, _value),
          child: Image.asset(drink.imageBlur,
              fit: BoxFit.cover, height: _bottomImg, width: _bottomImg),
        ),
      ],
    );
  }

  Widget _body(double _val) => SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: lerpDouble(30, size.height * .071, _val)),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Frappuccino',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: lerpDouble(10, size.height * .05, _val)),
            _brownBody(),
          ],
        ),
      );
  Widget _brownBody() {
    return SlideTransition(
        position: Tween<Offset>(
                begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInCubic)),
        child: Container(
          height: lerpDouble(0, size.height * .7, animation.value),
          padding: const EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            color: drink.darkColor,
            //  gradient: LinearGradient(colors: [drink.darkColor]),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Center(
                  child: RotatedBox(
                      quarterTurns: -1,
                      child: Icon(Icons.arrow_back_ios_new,
                          size: 40, color: Colors.white)),
                ),
                const SizedBox(height: 20),
                Text(
                  drink.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: TextStyle(color: Colors.white.withOpacity(0.6)),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 170,
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      3,
                      (index) => _cupContainer(index),
                    ),
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
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    )),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ));
  }

  Widget _cupContainer(int index) {
    final val = 1 - animation.value;
    final image = index == 0
        ? Image.asset('assets/starbuck/cup_L.png')
        : index == 1
            ? Image.asset('assets/starbuck/cup_M.png')
            : Image.asset('assets/starbuck/cup_s.png');
    return SizedBox(
      height: 150,
      width: 70,
      child: Column(
        children: [
          Container(
            height: 100,
            width: 70,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(40)),
              border: Border.all(color: Colors.grey, width: 1.5),
            ),
            child: Transform.translate(
              offset: Offset(-150 * val, -150 * val),
              child: image,
            ),
          ),
          Container(
            height: 50,
            width: 70,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(40)),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _title(double val) {
    final _font = lerpDouble(45, 20, val)!;
    return Container(
      height: size.height * .1,
      padding: EdgeInsets.only(
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
