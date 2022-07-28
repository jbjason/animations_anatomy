import 'package:flutter/material.dart';
import 'dart:math' as math;

class PizzaHomeScreen extends StatefulWidget {
  const PizzaHomeScreen({Key? key}) : super(key: key);
  @override
  State<PizzaHomeScreen> createState() => _PizzaHomeScreenState();
}

class _PizzaHomeScreenState extends State<PizzaHomeScreen> {
  final _controller1 = PageController(viewportFraction: 0.5, initialPage: 0);
  final _controller2 = PageController(viewportFraction: 0.5, initialPage: 0);
  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 250,
              child: PageView.builder(
                controller: _controller1,
                itemCount: 8,
                physics: const ClampingScrollPhysics(),
                //  onPageChanged: (value) => setState(() => _currentIndex = value),
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _controller1,
                    builder: (context, _) {
                      double value = 0;
                      if (_controller1.position.haveDimensions) {
                        value = index - _controller1.page!;
                        //  (value * .1) .1 means both side will start rotaing
                        //| *.5 means both 90 angle e ghure jabe | *.9 means almost 180 angle for both sides
                        //| *1 means 180 degree angle for both sides . will rotate according to while changing page
                        value = (value * .4).clamp(-1, 1);
                      }
                      return Transform.rotate(
                        angle: math.pi * value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Image.asset('assets/card_/${5 + index}.jpg',
                              fit: BoxFit.cover),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 250,
              child: PageView.builder(
                controller: _controller2,
                itemCount: 8,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _controller2,
                    builder: (context, _) {
                      double value = 0;
                      if (_controller2.position.haveDimensions) {
                        value = index - _controller2.page!;
                        value = (value * .9).clamp(-1, 1);
                        // to reverse transition to topRightCorner to bottomLeft Corner transition
                        // if (value < 0) {
                        //   value = value.abs();
                        // } else {
                        //   value = -value;
                        // }
                      }
                      // like topLefCorner to bottomRightCorner (korner er moto) behave korbe
                      return Transform.translate(
                        // 18 to ...... will increase the previousItem to more on Top & nextItem to more on bottom
                        offset: Offset(0, 18 * math.pi * value),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Image.asset('assets/card_/${index + 1}.jpg',
                              fit: BoxFit.cover),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
