import 'package:flutter/material.dart';

class PizzaCartButton extends StatefulWidget {
  const PizzaCartButton({Key? key, required this.onPress}) : super(key: key);
  final VoidCallback onPress;
  @override
  State<PizzaCartButton> createState() => _PizzaCartButtonState();
}

class _PizzaCartButtonState extends State<PizzaCartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 200),
      lowerBound: 1.0,
      upperBound: 1.5,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        widget.onPress();
        await _controller.forward();
        await _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(scale: 2 - _controller.value, child: child!);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(colors: [
              Colors.orange.withOpacity(0.5),
              Colors.orange,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15,
                offset: Offset(0, 4),
                spreadRadius: 4.0,
              )
            ],
          ),
          child: const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
