import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class BatmanSignInScreen extends StatefulWidget {
  const BatmanSignInScreen({Key? key}) : super(key: key);
  @override
  State<BatmanSignInScreen> createState() => _BatmanSignInScreenState();
}

const _duration1 = Duration(seconds: 4);
const _duration2 = Duration(seconds: 6);

class _BatmanSignInScreenState extends State<BatmanSignInScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller1;
  late Animation<double> _batLogoAnimation, _batLogoMoveAnimation;
  late Animation<double> _buttonsMoveAnimation, _textOpacityAnimation;
  late Animation<double> _batmanImageAnimation;

  late AnimationController _controller2;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(vsync: this, duration: _duration1);
    _batLogoAnimation = Tween(begin: 30.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller1, curve: const Interval(0.0, 0.35)));
    _batLogoMoveAnimation =
        CurvedAnimation(parent: _controller1, curve: const Interval(.45, .55));
    _textOpacityAnimation =
        CurvedAnimation(parent: _controller1, curve: const Interval(.5, .6));
    _batmanImageAnimation = Tween(begin: 5.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller1, curve: const Interval(.65, 1)));
    _buttonsMoveAnimation =
        CurvedAnimation(parent: _controller1, curve: const Interval(.65, 1));

    _controller1.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFF100F0B),
        body: Stack(
          children: [
            // Batman Background
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: size.height * .45,
              child: Image.asset(
                'assets/batman_/batman_background.png',
                fit: BoxFit.cover,
              ),
            ),
            // Batman Image
            Positioned(
                left: -10,
                right: -10,
                top: 0,
                height: size.height * .6,
                child: BatmanImageAnimation(animation: _batmanImageAnimation)),
            // Batman Logo
            Positioned(
              top: size.height / 2.8,
              left: size.width / 2 - 100,
              height: 80,
              width: 200,
              child: BatmanLogoAnimation(
                  animation1: _batLogoAnimation,
                  animation2: _batLogoMoveAnimation),
            ),
            // Welcome Text & Buttons
            Positioned(
              left: 0,
              right: 0,
              top: size.height / 2,
              child: Column(
                children: [
                  // Welcome Text
                  BatmanWelcomeText(animation: _textOpacityAnimation),
                  const SizedBox(height: 20),
                  // Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 38),
                    child:
                        YellowButtonAnimation(animation: _buttonsMoveAnimation),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BatmanLogoAnimation extends StatelessWidget {
  const BatmanLogoAnimation(
      {Key? key, required this.animation1, required this.animation2})
      : super(key: key);
  final Animation<double> animation1, animation2;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([animation1, animation2]),
      builder: (context, _) => Transform.translate(
        offset: Offset(0, lerpDouble(100, 0, animation2.value)!),
        child: Transform.scale(
          scale: animation1.value,
          child: Image.asset('assets/batman_/batman_logo.png',
              fit: BoxFit.contain),
        ),
      ),
    );
  }
}

class BatmanImageAnimation extends StatelessWidget {
  const BatmanImageAnimation({Key? key, required this.animation})
      : super(key: key);
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => Transform.scale(
        scale: animation.value,
        child: Image.asset('assets/batman_/batman_alone.png',
            fit: BoxFit.fitHeight),
      ),
    );
  }
}

class BatmanWelcomeText extends StatelessWidget {
  const BatmanWelcomeText({Key? key, required this.animation})
      : super(key: key);
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final _val = animation.value;
        return Opacity(
          opacity: _val,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text('WELCOME TO',
                  style: TextStyle(fontSize: 22, color: Colors.white)),
              Text('GOTHAM CITY',
                  style: TextStyle(fontSize: 35, color: Colors.white)),
              Text('YOU NEED ACCESS TO ENTER CITY',
                  style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        );
      },
    );
  }
}

class YellowButtonAnimation extends StatelessWidget {
  const YellowButtonAnimation({Key? key, required this.animation})
      : super(key: key);
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final _val = animation.value;
        return Opacity(
          opacity: _val,
          child: Transform.translate(
            offset: Offset(0, lerpDouble(150, 0, _val)!),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                YellowButton(onpress: () {}, text: 'LOGIN'),
                YellowButton(onpress: () {}, text: 'SIGNUP'),
              ],
            ),
          ),
        );
      },
    );
  }
}

class YellowButton extends StatelessWidget {
  const YellowButton({Key? key, required this.onpress, required this.text})
      : super(key: key);
  final VoidCallback onpress;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onpress,
        child: Container(
          height: 55,
          color: const Color(0xFFFDE86A),
          child: Stack(
            children: [
              Center(
                child: Text(
                  text,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              if (text == 'LOGIN')
                Positioned(
                  right: 5,
                  child: Transform.rotate(
                    angle: vector.radians(-40),
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'assets/batman_/batman_logo.png',
                      height: 30,
                      width: 60,
                      color: Colors.black26,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              if (text != 'LOGIN')
                Positioned(
                  left: 5,
                  child: Transform.rotate(
                    angle: vector.radians(40),
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      'assets/batman_/batman_logo.png',
                      height: 30,
                      width: 60,
                      color: Colors.black26,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
