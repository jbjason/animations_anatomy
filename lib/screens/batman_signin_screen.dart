import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0XFF100F0B),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: size.height * .4,
            child: Image.asset('assets/batman_/batman_background.png'),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: size.height * .1,
            height: size.height * .4,
            child: Image.asset('assets/batman_/batman_alone.png'),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: size.height / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('WELCOME TO', style: TextStyle(fontSize: 22)),
                const Text('GOTHAM CITY', style: TextStyle(fontSize: 35)),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 38),
                  child: Column(
                    children: [
                      YellowButton(onpress: () {}, text: 'LOGIN'),
                      YellowButton(onpress: () {}, text: 'SIGNUP'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
          height: 80,
          color: const Color(0x0FFDE86A),
          child: Stack(
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: GoogleFonts.vidaloka(
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              if (text == 'LOGIN')
                Transform.rotate(
                  angle: vector.radians(-40),
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/batman_/batman_logo.png',
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              if (text != 'LOGIN')
                Transform.rotate(
                  angle: vector.radians(40),
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/batman_/batman_logo.png',
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
