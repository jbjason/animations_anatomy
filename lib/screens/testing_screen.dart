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
            transform: Matrix4.identity()..scale(_val * 2),
            child: const FlutterLogo(size: 250),
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
