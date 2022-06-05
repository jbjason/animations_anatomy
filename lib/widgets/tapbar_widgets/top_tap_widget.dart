import 'package:flutter/material.dart';

class TopTapWidget extends StatelessWidget {
  const TopTapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'HomePage',
            style: TextStyle(
                color: Colors.blue[900],
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          const CircleAvatar(
              radius: 17, backgroundImage: AssetImage('assets/card_/jb.jpg')),
        ],
      ),
    );
  }
}
