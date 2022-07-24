import 'dart:math';

import 'package:animations_anatomy/models/superhero.dart';
import 'package:flutter/material.dart';

class SuperHeroChlngScreen extends StatefulWidget {
  const SuperHeroChlngScreen({Key? key}) : super(key: key);

  @override
  State<SuperHeroChlngScreen> createState() => _SuperHeroChlngScreenState();
}

class _SuperHeroChlngScreenState extends State<SuperHeroChlngScreen> {
  late PageController _controller;
  int _index = 0, _auxIndex = 1;
  double _percent = 0.0, _auxPercent = 1.0;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    _controller.addListener(_pageListener);
    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Movies', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          Stack(
            children: [
              Transform.translate(
                offset: Offset(0, 100 * _auxPercent),
                child: SuperHeroCard(
                    superhero: heroes[_auxIndex], factorChange: _auxPercent),
              ),
              Transform.rotate(
                angle: (-pi * .5) * _percent,
                child: Transform.translate(
                  offset: Offset(-800 * _percent, -50 * _percent),
                  child: SuperHeroCard(
                      superhero: heroes[_index], factorChange: _percent),
                ),
              ),
            ],
          ),
          PageView.builder(
            controller: _controller,
            // -1  Cz Aux value will be always 1+ than currentIndex so last Position may occurs error so -1
            itemCount: heroes.length - 1,
            itemBuilder: (context, index) {
              return const SizedBox();
            },
          )
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
    final separation = size.height * .24;
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
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          Positioned(
            top: separation * factorChange,
            left: 20,
            right: 20,
            bottom: size.height * .35,
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
