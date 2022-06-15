import 'package:animations_anatomy/constants/constants.dart';
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
    _controller = PageController(viewportFraction: 0.9, initialPage: 0);
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
              return HeroItem(travel: travels[index]);
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => HeroDetails1(travel: travel))),
          child: RotatedBox(
            quarterTurns: 0,
            child: Hero(
              tag: travel.imageFront + travel.imageBack,
              child: Image.asset(travel.imageFront,
                  height: 400, fit: BoxFit.cover),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Text(
          travel.title,
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class HeroDetails1 extends StatelessWidget {
  const HeroDetails1({Key? key, required this.travel}) : super(key: key);
  final Travel travel;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new)),
              Hero(
                tag: travel.imageFront + travel.imageBack,
                child: Image.asset(travel.imageFront, fit: BoxFit.cover),
              ),
              const SizedBox(height: 40),
              Center(
                child: Text(
                  travel.title,
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                '$detailsText\n$detailsText',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
