import 'package:animations_anatomy/models/superhero.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/superhero_widgets/superhero_appbar.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/superhero_widgets/superhero_details_column.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/superhero_widgets/superhero_home_body.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/superhero_widgets/superhero_title_and_text.dart';
import 'package:flutter/material.dart';

class SuperHeroChlngScreen extends StatefulWidget {
  const SuperHeroChlngScreen({Key? key}) : super(key: key);
  @override
  State<SuperHeroChlngScreen> createState() => _SuperHeroChlngScreenState();
}

const _duration = Duration(milliseconds: 4000);

class _SuperHeroChlngScreenState extends State<SuperHeroChlngScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late PageController _controller;
  late Animation<double> _cardToTopAnim, _cardRemoveAnim;
  late Animation<double> _titleAnim, _detailColumnAnim;
  late Animation<Color?> _titleColorAnim;
  int _index = 0, _auxIndex = 1;
  double _percent = 0.0, auxPercent = 1.0;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: _duration);
    _setAnimation();
    _controller = PageController(initialPage: 0);
    _controller.addListener(_pageListener);
    super.initState();
  }

  void _setAnimation() {
    _cardToTopAnim = CurvedAnimation(
        parent: _animationController, curve: const Interval(0, .2));
    _titleAnim = CurvedAnimation(
        parent: _animationController,
        curve: const Interval(.25, .4, curve: Curves.bounceInOut));
    _cardRemoveAnim = CurvedAnimation(
        parent: _animationController, curve: const Interval(.45, .8));
    _titleColorAnim = ColorTween(begin: Colors.white, end: Colors.grey[800])
        .animate(CurvedAnimation(
            parent: _animationController,
            curve: const Interval(.575, .675, curve: Curves.decelerate)));
    _detailColumnAnim = CurvedAnimation(
        parent: _animationController, curve: const Interval(.8, 1));
  }

  @override
  void dispose() {
    _controller.removeListener(_pageListener);
    _controller.dispose();
    super.dispose();
  }

  void _pageListener() {
    _index = _controller.page!.floor();
    _auxIndex = _index + 1;
    _percent = (_controller.page! - _index).abs();
    auxPercent = 1.0 - _percent;
    setState(() {});
  }

  // percent 1 to 0
  // auxPercent 0 to 1
  @override
  Widget build(BuildContext context) {
    const heroes = Superhero.marvelHeroes;
    return Scaffold(
      body: Stack(
        children: [
          // backCard ,front & back Image
          SuperHeroHomeBody(
              auxPercent: auxPercent,
              heroes: heroes,
              auxIndex: _auxIndex,
              percent: _percent,
              index: _index,
              firstAnim: _cardToTopAnim,
              secondAnim: _titleAnim,
              thirdAnim: _cardRemoveAnim),
          // title ,name ,learn More button
          SuperHeroTitleAndText(
              animation: _titleAnim,
              hero: heroes[_index],
              titleColorAnim: _titleColorAnim),
          // Page Controller
          GestureDetector(
              onTap: _startAnimation,
              child: PageView.builder(
                  controller: _controller,
                  // -1  Cz Aux value will be always 1+ than currentIndex so last Position may occurs error so -1
                  itemCount: heroes.length - 1,
                  itemBuilder: (context, _) => const SizedBox())),
          // Details COlumn 2nd page
          Positioned(
              bottom: 0,
              left: 30,
              right: 30,
              child: SuperHeroDetailsColumn(
                  heroes: heroes, index: _index, animation: _detailColumnAnim)),
          // AppBar
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SuperHeroAppbar(
                  animation: _cardToTopAnim, onTap: _startAnimation)),
        ],
      ),
    );
  }

  void _startAnimation() => _animationController.isDismissed
      ? _animationController.forward(from: 0.0)
      : _animationController.reverse();
}
