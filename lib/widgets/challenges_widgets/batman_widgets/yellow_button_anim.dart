import 'package:animations_anatomy/widgets/challenges_widgets/batman_widgets/yellow_button.dart';
import 'package:flutter/material.dart';

class YellowButtonAnimation extends StatelessWidget {
  const YellowButtonAnimation(
      {Key? key, required this.animation, required this.onPressed})
      : super(key: key);
  final VoidCallback onPressed;
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
            offset: Offset(0, 150 * (1 - _val)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                YellowButton(onpress: () {}, text: 'LOGIN'),
                YellowButton(onpress: onPressed, text: 'SIGNUP'),
              ],
            ),
          ),
        );
      },
    );
  }
}
