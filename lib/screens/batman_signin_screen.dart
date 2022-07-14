import 'package:flutter/material.dart';

class BatmanSignInScreen extends StatefulWidget {
  const BatmanSignInScreen({Key? key}) : super(key: key);

  @override
  State<BatmanSignInScreen> createState() => _BatmanSignInScreenState();
}

class _BatmanSignInScreenState extends State<BatmanSignInScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
