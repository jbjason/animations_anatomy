import 'package:animations_anatomy/widgets/loading_widgets/loading_bubbles.dart';
import 'package:animations_anatomy/widgets/loading_widgets/loading_home.dart';
import 'package:flutter/material.dart';

const mainDataBackupColor = Color(0xFF5113AA);
const secondaryDataBackupColor = Color(0xFFBC53FA);
const backgroundColor = Color(0xFFfce7fe);

class LoadingScreen1 extends StatefulWidget {
  const LoadingScreen1({Key? key}) : super(key: key);
  @override
  State<LoadingScreen1> createState() => _LoadingScreen1State();
}

class _LoadingScreen1State extends State<LoadingScreen1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progessAnimation;
  late Animation<double> _cloudAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4000));
    _progessAnimation =
        CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.65));
    _cloudAnimation =
        CurvedAnimation(parent: _controller, curve: const Interval(0.7, 0.9));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            LoadingHome(
              progressAnimation: _progessAnimation,
              onPressed: () => _controller.forward(),
            ),
            LoadingBubbles(
                cloudAnimation: _cloudAnimation,
                progressAnimation: _progessAnimation),
          ],
        ),
      ),
    );
  }
}
