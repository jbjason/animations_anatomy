import 'package:flutter/material.dart';

class TopTapWidget extends StatelessWidget {
  const TopTapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Homepage',
            style: TextStyle(
                color: Colors.teal[900],
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
          const CircleAvatar(
              radius: 17, backgroundImage: AssetImage('assets/card_/jb.jpg')),
        ],
      ),
    );
  }
}
