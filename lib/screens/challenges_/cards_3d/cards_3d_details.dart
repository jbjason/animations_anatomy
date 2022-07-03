import 'package:animations_anatomy/models/book.dart';
import 'package:animations_anatomy/screens/challenges_/cards_3d/cards_3d_screen.dart';
import 'package:flutter/material.dart';

class Cards3dDetails extends StatelessWidget {
  const Cards3dDetails({Key? key, required this.card}) : super(key: key);
  final Book card;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: kToolbarHeight + 10,
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon:
                      const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                  onPressed: () => Navigator.maybePop(context),
                ),
              ),
            ),
            const SizedBox(height: 70),
            Align(
              child: SizedBox(
                height: 190,
                width: 190,
                child: Hero(
                    tag: card.author + card.title,
                    child: Cards3dImage(card: card)),
              ),
            ),
            const SizedBox(height: 50),
            Text(
              card.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            Text(
              card.author,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
