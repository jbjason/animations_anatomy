import 'package:animations_anatomy/widgets/home_widgets/trip_list.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class TestingScreen extends StatefulWidget {
  const TestingScreen({Key? key}) : super(key: key);

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  double _val = 0.1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300]!,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateZ(math.pi / 2 * (1 - _val)),
            child: Image.asset('assets/${trips[0].img}', fit: BoxFit.cover),
          ),
          Slider.adaptive(
            value: _val,
            onChanged: (v) {
              setState(() => _val = v);
            },
          )
        ],
      ),
    );
  }
}
