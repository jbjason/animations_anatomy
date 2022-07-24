import 'package:animations_anatomy/widgets/challenges_widgets/pizza_widgets/pizza_cart_button.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/pizza_widgets/pizza_chlng_details.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/pizza_widgets/pizza_ingredient.dart';
import 'package:flutter/material.dart';

const _pizzaCartSize = 55.0;

class PizzaChlngScreen extends StatelessWidget {
  const PizzaChlngScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Dominoz De Lata',
          style: TextStyle(color: Colors.brown, fontSize: 24),
        ),
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.brown)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.brown),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 50,
            left: 10,
            right: 10,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: const [
                  Expanded(flex: 6, child: PizzaChlngDetails()),
                  Expanded(flex: 3, child: PizzaIngredients()),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: size.width / 2 - _pizzaCartSize / 2,
            height: _pizzaCartSize,
            width: _pizzaCartSize,
            child: PizzaCartButton(onPress: () {}),
          )
        ],
      ),
    );
  }
}
