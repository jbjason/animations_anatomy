import 'package:animations_anatomy/models/trip.dart';
import 'package:animations_anatomy/screens/challenges_/hero_anim/hero_details1.dart';
import 'package:flutter/material.dart';

class HeroChallenge1 extends StatefulWidget {
  const HeroChallenge1({Key? key}) : super(key: key);
  @override
  State<HeroChallenge1> createState() => _HeroChallenge1State();
}

class _HeroChallenge1State extends State<HeroChallenge1>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animController;
  final notifierValue = ValueNotifier(0.0);

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.7, initialPage: 0);
    _pageController.addListener(_listener);
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    super.initState();
  }

  void _listener() => notifierValue.value = _pageController.page!;

  @override
  void dispose() {
    _animController.dispose();
    _pageController.removeListener(_listener);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Stack(
          children: [
            ValueListenableBuilder<double>(
              valueListenable: notifierValue,
              builder: (context, value, child) => PageView.builder(
                controller: _pageController,
                itemBuilder: (context, index) {
                  final percent = 1 - (index - value).abs();
                  final _opacity = (percent).clamp(0.7, 1.0);
                  return Opacity(
                    opacity: _opacity,
                    child: Transform.scale(
                      scale: _opacity,
                      child: HeroItem(
                        travel: trips1[index],
                        function: _onPressed,
                      ),
                    ),
                  );
                },
                itemCount: trips1.length,
              ),
            ),
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              height: kToolbarHeight,
              child: AnimatedBuilder(
                animation: _animController,
                builder: (context, _) => Transform.translate(
                  offset: Offset(0, -70 * _animController.value),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: const Text(
                      'Space\'X Model',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    actions: const [
                      Icon(Icons.search_off, color: Colors.black)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressed(Trip travel) async {
    _animController.forward();
    await Navigator.of(context).push(
      PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          pageBuilder: ((context, animation, secondaryAnimation) {
            return FadeTransition(
                opacity: animation, child: HeroDetails1(travel: travel));
          })),
    );
    _animController.reverse();
  }
}

class HeroItem extends StatelessWidget {
  const HeroItem({Key? key, required this.travel, required this.function})
      : super(key: key);
  final Trip travel;
  final Function(Trip trip) function;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * .1),
        SizedBox(
          height: size.height * .7,
          width: size.width,
          child: InkWell(
              onTap: () => function(travel),
              child: Image.asset(travel.img, fit: BoxFit.fitHeight)),
        ),
        //const SizedBox(height: 40),
        Text(
          travel.title,
          style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
