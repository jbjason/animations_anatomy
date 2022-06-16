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
  final notifierValue = ValueNotifier(0.0);
  final _isSelected = ValueNotifier(false);

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.7, initialPage: 0);
    _pageController.addListener(_listener);
    super.initState();
  }

  void _listener() => notifierValue.value = _pageController.page!;

  @override
  void dispose() {
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
                        onItemSelected: (val) => _isSelected.value = val,
                      ),
                    ),
                  );
                },
                itemCount: trips1.length,
              ),
            ),
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              height: kToolbarHeight,
              child: ValueListenableBuilder(
                valueListenable: _isSelected,
                builder: (context, _, __) => TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.fastOutSlowIn,
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  builder: (context, val, child) => Transform.translate(
                      offset: Offset(0, -50 * val), child: child),
                  child: AppBar(
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
}

class HeroItem extends StatelessWidget {
  const HeroItem({Key? key, required this.travel, required this.onItemSelected})
      : super(key: key);
  final Trip travel;
  final ValueChanged<bool> onItemSelected;
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
              onTap: () {
                onItemSelected(true);
                Navigator.of(context).push(
                  PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: ((context, animation, secondaryAnimation) {
                        return FadeTransition(
                            opacity: animation,
                            child: HeroDetails1(travel: travel));
                      })),
                );
              },
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
