import 'package:animations_anatomy/widgets/challenges_widgets/batman_widgets/signup_input_button.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/batman_widgets/yellow_button.dart';
import 'package:flutter/material.dart';

class SignUpWidgets extends StatelessWidget {
  const SignUpWidgets({Key? key, required this.animation}) : super(key: key);
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset(0, 150 * (1 - animation.value)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'GET ACCESS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text('CREATE ACCOUNT TO GET PASS',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11, color: Colors.grey)),
                  const SizedBox(height: 10),
                  const SignUpInputButton(text: 'FULL NAME'),
                  const SignUpInputButton(text: 'EMAIL'),
                  const SignUpInputButton(text: 'PASSWORD', password: true),
                  YellowButton(onpress: () {}, text: 'SIGNUP'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
