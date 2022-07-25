import 'dart:math';

import 'package:animations_anatomy/models/superhero.dart';
import 'package:flutter/material.dart';

class SuperHeroChlngScreen extends StatefulWidget {
  const SuperHeroChlngScreen({Key? key}) : super(key: key);
  @override
  State<SuperHeroChlngScreen> createState() => _SuperHeroChlngScreenState();
}

const _duration = Duration(seconds: 2);

class _SuperHeroChlngScreenState extends State<SuperHeroChlngScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late PageController _controller;
  late Animation<double> _backCardToTopAnim, _backCardRemoveAnim;
  late Animation<double> _imageTitleAnim, _detailColumnAnim;
  int _index = 0, _auxIndex = 1;
  double _percent = 0.0, _auxPercent = 1.0;

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
    _backCardToTopAnim = CurvedAnimation(
        parent: _animationController, curve: const Interval(0, .3));
    _imageTitleAnim = CurvedAnimation(
        parent: _animationController,
        curve: const Interval(.15, .5, curve: Curves.bounceIn));
    _backCardRemoveAnim = CurvedAnimation(
        parent: _animationController, curve: const Interval(.55, .8));
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
    _auxPercent = 1.0 - _percent;
    setState(() {});
  }

  // percent 1 to 0
  // auxPercent 0 to 1
  @override
  Widget build(BuildContext context) {
    const heroes = Superhero.marvelHeroes;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SuperHeroHomeBody(
            auxPercent: _auxPercent,
            heroes: heroes,
            auxIndex: _auxIndex,
            percent: _percent,
            index: _index,
            firstAnim: _backCardToTopAnim,
            secondAnim: _backCardRemoveAnim,
          ),
          PageView.builder(
            controller: _controller,
            // -1  Cz Aux value will be always 1+ than currentIndex so last Position may occurs error so -1
            itemCount: heroes.length - 1,
            itemBuilder: (context, index) {
              return const SizedBox();
            },
          ),
          Positioned(
            bottom: 0,
            left: 30,
            right: 30,
            height: size.height * .5,
            child: SuperHeroDetailsColumn(
                heroes: heroes, index: _index, animation: _detailColumnAnim),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SuperHeroAppbar(animation: _backCardToTopAnim),
          ),
        ],
      ),
    );
  }
}

class SuperHeroAppbar extends StatelessWidget {
  const SuperHeroAppbar({
    Key? key,
    required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: AnimatedBuilder(
        animation: animation,
        builder: (context, _) => Transform.translate(
          offset: Offset(0, -100 * animation.value),
          child: const Text('Movies', style: TextStyle(color: Colors.black)),
        ),
      ),
      leading: IconButton(
        onPressed: () => Navigator.maybePop(context),
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
      ),
    );
  }
}

class SuperHeroDetailsColumn extends StatelessWidget {
  const SuperHeroDetailsColumn({
    Key? key,
    required this.heroes,
    required this.animation,
    required int index,
  })  : _index = index,
        super(key: key);

  final List<Superhero> heroes;
  final int _index;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return child!;
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30,
              alignment: Alignment.centerRight,
              child: Image.asset('assets/superhero_/marvel_logo.jpg'),
            ),
            const SizedBox(height: 20),
            Text(
              heroes[_index].description,
              maxLines: 4,
              style: const TextStyle(color: Colors.grey, fontSize: 11),
            ),
            const SizedBox(height: 20),
            const Text('movies', style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 300,
              child: PageView.builder(
                itemCount: heroes[_index].movies.length,
                itemBuilder: (context, index) {
                  final heroMovie = heroes[_index].movies[index];
                  return Container(
                    height: 150,
                    width: 150,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage(heroMovie.urlImage)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SuperHeroHomeBody extends StatelessWidget {
  const SuperHeroHomeBody({
    Key? key,
    required double auxPercent,
    required this.heroes,
    required int auxIndex,
    required double percent,
    required int index,
    required this.firstAnim,
    required this.secondAnim,
  })  : _auxPercent = auxPercent,
        _auxIndex = auxIndex,
        _percent = percent,
        _index = index,
        super(key: key);

  final double _auxPercent;
  final List<Superhero> heroes;
  final int _auxIndex;
  final double _percent;
  final int _index;
  final Animation<double> firstAnim, secondAnim;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: Listenable.merge([firstAnim, secondAnim]),
      builder: (context, _) => Stack(
        children: [
          // backImage
          Transform.translate(
            offset: Offset(0, 100 * _auxPercent),
            child: SuperHeroCard(
                superhero: heroes[_auxIndex], factorChange: _auxPercent),
          ),
          // Front Image
          Transform.rotate(
            angle: (-pi * .5) * _percent,
            child: Transform.translate(
              offset: Offset(-800 * _percent, -50 * _percent),
              child: SuperHeroCard(
                  superhero: heroes[_index], factorChange: _percent),
            ),
          ),
          // title ,name ,learn More button
          Positioned(
            bottom: size.height * .15,
            left: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heroes[_index].heroName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 45,
                      letterSpacing: 1.7),
                ),
                Text(
                  heroes[_index].name,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: 20),
                const Text.rich(
                  TextSpan(
                    text: 'learn more',
                    style: TextStyle(color: Colors.yellow),
                    children: [
                      WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child:
                              Icon(Icons.arrow_right_alt, color: Colors.yellow))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SuperHeroCard extends StatelessWidget {
  const SuperHeroCard(
      {Key? key, required this.superhero, required this.factorChange})
      : super(key: key);
  final Superhero superhero;
  final double factorChange;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final separation = size.height * .35;
    return OverflowBox(
      maxHeight: size.height,
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          Positioned.fill(
            top: separation,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Color(superhero.rawColor),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(50)),
              ),
            ),
          ),
          Positioned(
            top: separation * factorChange,
            left: 20,
            right: 20,
            bottom: size.height * .2,
            child: Opacity(
              opacity: 1 - factorChange,
              child: Image.asset(superhero.pathImage),
            ),
          ),
        ],
      ),
    );
  }
}
