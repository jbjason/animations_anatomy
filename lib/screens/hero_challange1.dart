import 'package:animations_anatomy/models/travel.dart';
import 'package:flutter/material.dart';

class HeroChallenge1 extends StatefulWidget {
  const HeroChallenge1({Key? key}) : super(key: key);
  @override
  State<HeroChallenge1> createState() => _HeroChallenge1State();
}

class _HeroChallenge1State extends State<HeroChallenge1> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(viewportFraction: 0.8, initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: PageView.builder(
            controller: _controller,
            itemBuilder: (context, index) {
              return Container();
            },
            itemCount: travels.length,
          ),
        ),
      ),
    );
  }
}

class HeroItem extends StatelessWidget {
  const HeroItem({Key? key, required this.travel}) : super(key: key);
  final Travel travel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          RotatedBox(
              quarterTurns: 1,
              child: Image.asset(travel.imageFront,
                  height: 400, fit: BoxFit.cover)),
          const SizedBox(height: 40),
          Text(
            travel.title,
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
