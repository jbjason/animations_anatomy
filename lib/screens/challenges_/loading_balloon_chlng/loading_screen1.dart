import 'package:animations_anatomy/screens/challenges_/loading_balloon_chlng/loading_bubbles.dart';
import 'package:animations_anatomy/screens/challenges_/loading_balloon_chlng/loading_ending.dart';
import 'package:animations_anatomy/screens/challenges_/loading_balloon_chlng/loading_home.dart';
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
  late Animation<double> _bubbleAnimation;
  late Animation<double> _endingAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4000));
    _progessAnimation =
        CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6));
    _cloudAnimation = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.65, 0.8, curve: Curves.easeOut));
    _endingAnimation =
        CurvedAnimation(parent: _controller, curve: const Interval(.8, 1));
    _bubbleAnimation = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1, curve: Curves.decelerate));
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
                bubbleAnimation: _bubbleAnimation,
                progressAnimation: _progessAnimation),
            LoadingEnding(endingAnimation: _endingAnimation),
          ],
        ),
      ),
    );
  }
}
