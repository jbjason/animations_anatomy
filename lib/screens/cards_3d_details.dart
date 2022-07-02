import 'package:animations_anatomy/models/book.dart';
import 'package:animations_anatomy/screens/cards_3d_screen.dart';
import 'package:flutter/material.dart';

class Cards3dDetails extends StatelessWidget {
  const Cards3dDetails({Key? key, required this.card}) : super(key: key);
  final Book card;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black45),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 100),
          Align(
            child: SizedBox(
              height: 190,
              width: 190,
              child: Cards3dImage(card: card),
            ),
          ),
          const SizedBox(height: 50),
          Text(
            card.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          Text(
            card.author,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
