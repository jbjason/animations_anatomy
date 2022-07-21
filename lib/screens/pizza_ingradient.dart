import 'package:animations_anatomy/models/ingredient.dart';
import 'package:flutter/material.dart';

class PizzaIngradients extends StatelessWidget {
  const PizzaIngradients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: ingradients.length,
      itemBuilder: (context, index) =>
          PizzaIngradientItem(ingradient: ingradients[index]),
    );
  }
}

class PizzaIngradientItem extends StatelessWidget {
  const PizzaIngradientItem({Key? key, required this.ingradient})
      : super(key: key);
  final Ingradient ingradient;

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
          child: Image.asset(ingradient.image, fit: BoxFit.contain),
        ),
      ),
    );
    return Center(
        child: Draggable(feedback: _child, data: ingradient, child: _child));
  }
}
