import 'dart:math';
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
                tween: Tween<double>(begin: -pi / 2, end: 0),
                duration: _duration,
                builder: (context, double val, _) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(val * pi / 180),
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

class DrawerItemList extends StatefulWidget {
  const DrawerItemList({Key? key, required this.animation}) : super(key: key);
  final Animation<double> animation;
  @override
  State<DrawerItemList> createState() => _DrawerItemListState();
}

class _DrawerItemListState extends State<DrawerItemList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 200),
          const Text('jb jason'),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('-'),
                    const SizedBox(height: 20),
                    AnimatedCharacters(
                      style: const TextStyle(fontSize: 30),
                      text: _categoryList[0],
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 100,
            width: 200,
            child: ElevatedButton(child: const Text('Press'), onPressed: () {}),
          ),
        ],
      ),
    );
  }
}

class AnimatedCharacters extends StatelessWidget {
  AnimatedCharacters({Key? key, required this.style, required this.text})
      : super(key: key) {
    characters = text.split('');
  }
  final String text;
  late List<String> characters;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return Row(
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
