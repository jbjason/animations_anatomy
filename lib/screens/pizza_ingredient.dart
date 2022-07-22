import 'package:animations_anatomy/models/ingredient.dart';
import 'package:animations_anatomy/screens/pizza_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PizzaIngredients extends StatelessWidget {
  const PizzaIngredients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PizzaBloc>(context);
    return AnimatedBuilder(
      animation: bloc,
      builder: (context, _) => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          final ingredient = ingredients[index];
          return PizzaIngredientItem(
            ingredient: ingredient,
            exist: bloc.containsIngredient(ingredient),
            onTap: () => bloc.removeIngredient(ingredient),
          );
        },
      ),
    );
  }
}

// here drag korar shomoy PizzaIngredientItem empty howar kaj baki
class PizzaIngredientItem extends StatelessWidget {
  const PizzaIngredientItem(
      {Key? key,
      required this.exist,
      required this.onTap,
      required this.ingredient})
      : super(key: key);
  final Ingredient ingredient;
  final bool exist;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Draggable(
        feedback: _buildChild(),
        data: ingredient,
        childWhenDragging: _childWhileDragging(),
        child: _buildChild(),
      ),
    );
  }

  // here exist will work in reverse mode
  Widget _buildChild() {
    return GestureDetector(
      onTap: !exist ? onTap : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFF5EED3),
            border:
                !exist ? Border.all(color: Colors.redAccent, width: 2) : null,
            boxShadow: const [
              BoxShadow(
                  blurRadius: 10.0,
                  color: Colors.black26,
                  spreadRadius: 3.0,
                  offset: Offset(0, 5))
            ],
          ),
          child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(ingredient.image, fit: BoxFit.contain)),
        ),
      ),
    );
  }

  Widget _childWhileDragging() => Padding(
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
        ),
      );
}
