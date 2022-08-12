import 'dart:ui';
import 'package:animations_anatomy/screens/challenges_/drawer2_chlng/drawer2_item.dart';
import 'package:animations_anatomy/screens/challenges_/drawer2_chlng/drawer2_screen.dart';
import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 1500);

class Drawer2ItemsScreen extends StatefulWidget {
  const Drawer2ItemsScreen({Key? key}) : super(key: key);
  @override
  State<Drawer2ItemsScreen> createState() => _Drawer2ItemsScreenState();
}

class _Drawer2ItemsScreenState extends State<Drawer2ItemsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnim;
  late Animation<double> _heightAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _widthAnim = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, .5, curve: Curves.decelerate));
    _heightAnim =
        CurvedAnimation(parent: _controller, curve: const Interval(.5, 1.0));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Stack(
        children: [
          InkWell(
            onTap: () => _startAnim(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Drawer2Item(text: _categoryList[0]),
                const SizedBox(height: 20),
                Drawer2Item(text: _categoryList[1]),
                const SizedBox(height: 20),
                Drawer2Item(text: _categoryList[2]),
                const SizedBox(height: 20),
                Drawer2Item(text: _categoryList[3]),
                const SizedBox(height: 20),
                Drawer2Item(text: _categoryList[4]),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => Positioned(
              width: lerpDouble(0, size.width, _widthAnim.value),
              top: lerpDouble(size.height / 2 - 6, 0, _heightAnim.value),
              height: lerpDouble(3, size.height, _heightAnim.value),
              child: Container(color: Colors.white),
            ),
          ),
          _appBar(context),
        ],
      ),
    );
  }

  Widget _appBar(BuildContext context) => SizedBox(
        height: 60,
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: _startAnim,
            icon: AnimatedIcon(
              icon: AnimatedIcons.close_menu,
              progress: _controller,
            ),
          ),
        ),
      );

  void _startAnim() async {
    await _controller.forward(from: 0.0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const Drawer2Screen()),
        (route) => false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

const _categoryList = [
  'WRIST WATCH',
  'LEATHER GOODS',
  'PERFUME',
  'JEWELLERY',
  'SKINCARE'
];
