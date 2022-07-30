import 'package:animations_anatomy/models/ingredient.dart';
import 'package:flutter/material.dart';

const _color = Color.fromARGB(255, 190, 164, 154);

class PizzaHomeScreen extends StatelessWidget {
  const PizzaHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 236, 238),
      body: SafeArea(
        child: Column(
          children: const [
            PizzaTitleAndCart(),
            Expanded(child: PizzaHomeDetails()),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class PizzaHomeDetails extends StatefulWidget {
  const PizzaHomeDetails({Key? key}) : super(key: key);
  @override
  State<PizzaHomeDetails> createState() => _PizzaHomeDetailsState();
}

class _PizzaHomeDetailsState extends State<PizzaHomeDetails> {
  final _controller = PageController(viewportFraction: .7);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        // background COntainer
        Positioned(
          top: 0,
          width: size.width * .4,
          left: size.width * .3,
          bottom: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(size.width * .2, 100)),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, spreadRadius: 2, blurRadius: 80)
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: SafeArea(
            child: PageView.builder(
              controller: _controller,
              itemCount: pizzaList.length,
              itemBuilder: (context, index) {
                final _pizza = pizzaList[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Image.asset(_pizza.image)),
                    Text(_pizza.name, style: const TextStyle(color: _color)),
                    const Text('★★★★★'),
                    const SizedBox(height: 10),
                    Text(
                      '\$ ${_pizza.price}',
                      style: const TextStyle(
                          color: Colors.brown,
                          fontSize: 22,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                );
              },
            ),
          ),
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
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
              Icon(Icons.shopping_cart_outlined, color: _color)
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Icon(Icons.location_on, color: _color),
              SizedBox(width: 10),
              Text('Washington Park')
            ],
          ),
          Container(
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color.fromARGB(255, 179, 172, 114)),
            child: const Text('Pizza'),
          ),
        ],
      ),
    );
  }
}
