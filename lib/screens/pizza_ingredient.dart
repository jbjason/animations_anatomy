import 'package:animations_anatomy/models/ingredient.dart';
import 'package:flutter/material.dart';

class PizzaIngredients extends StatelessWidget {
  const PizzaIngredients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: ingredients.length,
      itemBuilder: (context, index) =>
          PizzaIngredientItem(ingredient: ingredients[index]),
    );
  }
}

class PizzaIngredientItem extends StatelessWidget {
  const PizzaIngredientItem({Key? key, required this.ingredient})
      : super(key: key);
  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    final _child = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFF5EED3),
          boxShadow: [
            BoxShadow(
                blurRadius: 10.0,
                color: Colors.black26,
                spreadRadius: 3.0,
                offset: Offset(0, 5))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(ingredient.image, fit: BoxFit.contain),
        ),
      ),
    );
    return Center(
        child: Draggable(feedback: _child, data: ingredient, child: _child));
  }
}
