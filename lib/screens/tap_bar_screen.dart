import 'package:flutter/material.dart';

class TapBarScreen extends StatefulWidget {
  const TapBarScreen({Key? key}) : super(key: key);
  @override
  State<TapBarScreen> createState() => _TapBarScreenState();
}

class _TapBarScreenState extends State<TapBarScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
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
                      radius: 17,
                      backgroundImage: AssetImage('assets/card_/jb.jpg')),
                ],
              ),
            ),
            Container(color: Colors.blueGrey, height: 80),
            Expanded(
              child: Container(
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
