import 'dart:math' as math;
import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 1000);

class Drawer2ChlngScreen extends StatelessWidget {
  const Drawer2ChlngScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _appBar(context),
            const SizedBox(height: 20),
            _gridView(),
          ],
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) => AppBar(
        title: const Text('Drawer2 Challenge'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: _duration,
                pageBuilder: (context, animation, secondaryAnimation) =>
                    DrawerItemList(animation: animation)));
          },
          icon: const Icon(Icons.menu),
        ),
      );
  Widget _gridView() => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisExtent: 200,
              mainAxisSpacing: 20,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return TweenAnimationBuilder(
                tween: Tween<double>(begin: -math.pi / 2, end: 0),
                duration: _duration,
                builder: (context, double val, _) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(val),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/card_/${1 + index}.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
}

class DrawerItemList extends StatelessWidget {
  const DrawerItemList({Key? key, required this.animation}) : super(key: key);
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) => _drawerItem(_categoryList[index])),
    );
  }

  Widget _drawerItem(String text) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Row(
          children: [
            const Text('-', style: TextStyle(fontSize: 30)),
            const SizedBox(width: 30),
            AnimatedCharacters(
              style: const TextStyle(fontSize: 25),
              text: text,
            )
          ],
        ),
      );
}

class AnimatedCharacters extends StatelessWidget {
  const AnimatedCharacters({Key? key, required this.style, required this.text})
      : super(key: key);
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    List<String> characters = text.split('');
    return ClipRect(
      child: Row(
        children: [
          ...characters.asMap().entries.map(
            (char) {
              return FutureBuilder(
                future: Future.delayed(Duration(milliseconds: char.key * 200)),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  }
                  return TweenAnimationBuilder(
                    tween: Tween<double>(begin: 30, end: 0),
                    duration: const Duration(milliseconds: 1000),
                    builder: (context, double val, chil) {
                      return Transform.translate(
                        offset: Offset(0, val),
                        child: chil,
                      );
                    },
                    child: Text(char.value, style: style),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}

const List<String> _categoryList = [
  'WRIST WATCH',
  'LEATHER GOODS',
  'PERFUME',
  'JEWELLERY',
  'SKINCARE',
];
