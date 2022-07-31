import 'dart:math' as math;
import 'package:animations_anatomy/models/pizza.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/pizza_widgets/pizza_chlng_details.dart';
import 'package:flutter/material.dart';

const _color = Color.fromARGB(255, 241, 236, 238);
const _textColor = Color.fromARGB(255, 155, 123, 111);

class PizzaHomeScreen extends StatelessWidget {
  const PizzaHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            PizzaTitleAndCart(),
            Expanded(child: PizzaHomeDetails()),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class PizzaHomeDetails extends StatelessWidget {
  const PizzaHomeDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        // background COntainer
        Positioned(
          top: 0,
          width: size.width * .6,
          left: size.width * .2,
          bottom: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(size.width * .3, size.height * .2)),
              gradient: LinearGradient(
                  colors: [Colors.white.withOpacity(0.3), _color],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 2),
                    color: Colors.black12,
                    spreadRadius: 10,
                    blurRadius: 80)
              ],
            ),
          ),
        ),

        // pageView Builder
        const PizzaHomePageView(),
      ],
    );
  }
}

class PizzaHomePageView extends StatefulWidget {
  const PizzaHomePageView({Key? key}) : super(key: key);
  @override
  State<PizzaHomePageView> createState() => _PizzaHomePageViewState();
}

class _PizzaHomePageViewState extends State<PizzaHomePageView> {
  late PageController _controller;
  double _val = 0.0, _rotate = 0.0;
  double _scale = 0.0, _translateX = 0.0, _translateY = 0.0;

  @override
  void initState() {
    _controller = PageController(viewportFraction: .7, initialPage: 0);
    _controller.addListener(_listener);
    super.initState();
  }

  void _listener() {
    setState(() => _val = _controller.page!);
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: LayoutBuilder(
            builder: (context, constraints) => Stack(
              children: [
                Positioned(
                  left: 20,
                  child: Transform.rotate(
                      angle: math.pi / 2 * (1 - _rotate),
                      child: Image.asset('assets/pizza_/back1.png')),
                ),
                Positioned(
                  left: 30,
                  child: Transform.rotate(
                      angle: -math.pi / 2 * _rotate,
                      child: Image.asset('assets/pizza_/back1.png')),
                ),
                // dish Image
                Positioned(
                  top: 4,
                  left: constraints.maxWidth * .16,
                  width: constraints.maxWidth * .67,
                  height: constraints.maxHeight * .68,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15,
                          spreadRadius: 3,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Image.asset('assets/pizza_/dish.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
        PageView.builder(
          controller: _controller,
          physics: const ClampingScrollPhysics(),
          itemCount: pizzaList.length,
          itemBuilder: (context, index) {
            final _pizza = pizzaList[index];
            final _percent = index - _val;
            _rotate = _percent.clamp(0, 1);

            if (_controller.position.haveDimensions) {
              _scale = _percent.clamp(-.5, .5).abs();
              final _translate = _percent.clamp(-1.0, 2.0);
              if (_translate < 0) {
                _translateX = 100 * _translate.abs();
                _translateY = 180 * _translate.abs();
              } else if (_translate > 0) {
                _translateX = -100 * _translate;
                _translateY = 180 * _translate;
              } else {
                _translateX = 0;
                _translateY = 0;
              }
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Transform.translate(
                      offset: Offset(_translateX, _translateY),
                      child: Transform.scale(
                          scale: (1 - _scale),
                          child: Image.asset(_pizza.image)),
                    ),
                  ),
                ),
                Text(_pizza.name,
                    style: const TextStyle(color: _textColor, fontSize: 20)),
                const Text('★★★★★', style: TextStyle(color: _textColor)),
                const SizedBox(height: 10),
                Text(
                  '\$ ${_pizza.price}',
                  style: const TextStyle(
                      color: Colors.brown,
                      fontSize: 22,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PizzaSizedButton(
                      text: 'S',
                      selected: false,
                      onTap: () {},
                    ),
                    PizzaSizedButton(
                      text: 'M',
                      selected: true,
                      onTap: () {},
                    ),
                    PizzaSizedButton(
                      text: 'L',
                      selected: false,
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            );
          },
        ),
      ],
    );
  }
}

class PizzaTitleAndCart extends StatelessWidget {
  const PizzaTitleAndCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Order Manually',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 102, 76, 66)),
              ),
              Icon(Icons.shopping_cart_outlined, color: _textColor)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Icon(Icons.location_on, color: _textColor),
              SizedBox(width: 10),
              Text(
                'Washington Park',
                style: TextStyle(color: _textColor),
              )
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.orange[400]),
            child: const Center(
              child: Text(
                'Pizza',
                style: TextStyle(fontWeight: FontWeight.w900, color: _color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
