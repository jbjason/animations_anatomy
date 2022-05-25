import 'package:animations_anatomy/widgets/home_widgets/trip_list.dart';
import 'package:flutter/material.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(_val * 2, 1.0),
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
