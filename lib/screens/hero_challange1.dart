import 'package:animations_anatomy/models/trip.dart';
import 'package:animations_anatomy/screens/hero_anim/hero_details1.dart';
import 'package:flutter/material.dart';

class HeroChallenge1 extends StatefulWidget {
  const HeroChallenge1({Key? key}) : super(key: key);
  @override
  State<HeroChallenge1> createState() => _HeroChallenge1State();
}

class _HeroChallenge1State extends State<HeroChallenge1> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9, initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              return HeroItem(travel: trips1[index]);
            },
            itemCount: trips1.length,
          ),
        ),
      ),
    );
  }
}

class HeroItem extends StatelessWidget {
  const HeroItem({Key? key, required this.travel}) : super(key: key);
  final Trip travel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                    pageBuilder: ((context, animation, secondaryAnimation) {
                  return FadeTransition(
                      opacity: animation, child: HeroDetails1(travel: travel));
                })),
              );
            },
            child: Image.asset(travel.img, height: 400, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 40),
        Text(
          travel.title,
          style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
