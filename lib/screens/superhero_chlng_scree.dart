import 'dart:math';
import 'package:animations_anatomy/models/superhero.dart';
import 'package:flutter/material.dart';

class SuperHeroChlngScreen extends StatefulWidget {
  const SuperHeroChlngScreen({Key? key}) : super(key: key);
  @override
  State<SuperHeroChlngScreen> createState() => _SuperHeroChlngScreenState();
}

const _duration = Duration(milliseconds: 1500);

class _SuperHeroChlngScreenState extends State<SuperHeroChlngScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late PageController _controller;
  late Animation<double> _backCardToTopAnim, _backCardRemoveAnim;
  late Animation<double> _titleAnim, _detailColumnAnim;
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
    _backCardToTopAnim = CurvedAnimation(
        parent: _animationController, curve: const Interval(0, .3));
    _titleAnim = CurvedAnimation(
        parent: _animationController,
        curve: const Interval(.15, .4, curve: Curves.bounceOut));
    _backCardRemoveAnim = CurvedAnimation(
        parent: _animationController, curve: const Interval(.45, .8));
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
            firstAnim: _backCardToTopAnim,
            secondAnim: _backCardRemoveAnim,
          ),
          // title ,name ,learn More button
          SuperHeroTitleAndText(animation: _titleAnim, hero: heroes[_index]),
          // Page Controller
          PageView.builder(
            controller: _controller,
            // -1  Cz Aux value will be always 1+ than currentIndex so last Position may occurs error so -1
            itemCount: heroes.length - 1,
            itemBuilder: (context, index) {
              return const SizedBox();
            },
          ),
          // Details COlumn 2nd page
          // Positioned(
          //   bottom: 0,
          //   left: 30,
          //   right: 30,
          //   child: SuperHeroDetailsColumn(
          //       heroes: heroes, index: _index, animation: _detailColumnAnim),
          // ),
          // AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SuperHeroAppbar(
                animation: _backCardToTopAnim, onTap: _startAnimation),
          ),
        ],
      ),
    );
  }

  void _startAnimation() => _animationController.forward(from: 0.0);
}

class SuperHeroHomeBody extends StatelessWidget {
  const SuperHeroHomeBody(
      {Key? key,
      required this.auxPercent,
      required this.heroes,
      required this.auxIndex,
      required this.percent,
      required this.index,
      required this.firstAnim,
      required this.secondAnim})
      : super(key: key);

  final double auxPercent;
  final List<Superhero> heroes;
  final int auxIndex;
  final double percent;
  final int index;
  final Animation<double> firstAnim, secondAnim;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // backImage
        Transform.translate(
          offset: Offset(0, 100 * auxPercent),
          child: SuperHeroCard(
            superhero: heroes[auxIndex],
            factorChange: auxPercent,
            firstAnim: firstAnim,
            secondAnim: secondAnim,
          ),
        ),
        // Front Image
        Transform.rotate(
          angle: (-pi * .5) * percent,
          child: Transform.translate(
            offset: Offset(-800 * percent, -50 * percent),
            child: SuperHeroCard(
              superhero: heroes[index],
              factorChange: percent,
              firstAnim: firstAnim,
              secondAnim: secondAnim,
            ),
          ),
        ),
      ],
    );
  }
}

class SuperHeroTitleAndText extends StatelessWidget {
  const SuperHeroTitleAndText(
      {Key? key, required this.animation, required this.hero})
      : super(key: key);
  final Superhero hero;
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => Stack(
        children: [
          Positioned(
            bottom: size.height * .15 + (size.height * .2) * animation.value,
            left: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hero.heroName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 45,
                      letterSpacing: 1.7),
                ),
                Text(
                  hero.name,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: 20),
                // learn more button
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
      {Key? key,
      required this.superhero,
      required this.firstAnim,
      required this.secondAnim,
      required this.factorChange})
      : super(key: key);
  final Superhero superhero;
  final double factorChange;
  final Animation<double> firstAnim, secondAnim;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final separation = size.height * .35;
    return AnimatedBuilder(
      animation: Listenable.merge([firstAnim, secondAnim]),
      builder: (context, _) {
        return OverflowBox(
          maxHeight: size.height,
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              // Background Card
              Positioned(
                top: separation * (1 - firstAnim.value),
                left: 0,
                right: 0,
                height: size.height,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(superhero.rawColor),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(50)),
                  ),
                ),
              ),
              // superHero Main Image
              Positioned(
                top: separation * factorChange,
                left: 20,
                right: 20,
                bottom:
                    (size.height * .2) + (size.height * .3) * secondAnim.value,
                child: Opacity(
                  opacity: 1 - factorChange,
                  child: Image.asset(superhero.pathImage),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SuperHeroAppbar extends StatelessWidget {
  const SuperHeroAppbar(
      {Key? key, required this.animation, required this.onTap})
      : super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
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
      actions: [
        IconButton(
          onPressed: onTap,
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
      ],
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
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return SizedBox(
          height: size.height * .5,
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
                const Text('movies',
                    style: TextStyle(fontWeight: FontWeight.bold)),
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
      },
    );
  }
}
