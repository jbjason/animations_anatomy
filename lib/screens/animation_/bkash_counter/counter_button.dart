import 'package:flutter/material.dart';

class CounterButton extends StatefulWidget {
  const CounterButton({Key? key}) : super(key: key);
  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TweenAnimationBuilder(
          key: Key(counter.toString()),
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(seconds: 1),
          builder: (context, double val, child) {
            return Center(
              child: Stack(
                children: [
                  if (counter != 0)
                    Opacity(
                      opacity: 1 - val,
                      child: Transform.translate(
                        offset: Offset(val * 50.0, 0),
                        child: Text(
                          counter.toString(),
                          style: const TextStyle(fontSize: 26),
                        ),
                      ),
                    ),
                  Transform.translate(
                    offset: Offset(-50 * (1 - val), 0),
                    child: Text(
                      (counter + 1).toString(),
                      style: const TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        FloatingActionButton(
          child: const Icon(Icons.plus_one),
          onPressed: () => setState(() => counter++),
        ),
      ],
    );
  }
}
