import 'package:flutter/material.dart';

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
              Text(
                'GOTHAM CITY',
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text('YOU NEED ACCESS TO ENTER CITY',
                  style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        );
      },
    );
  }
}
