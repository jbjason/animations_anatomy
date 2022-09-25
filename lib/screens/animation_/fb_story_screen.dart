import 'dart:ui';
import 'package:animations_anatomy/models/book.dart';
import 'package:flutter/material.dart';

// ! Fb add-story animation
class FbStoryScreen extends StatefulWidget {
  const FbStoryScreen({Key? key}) : super(key: key);
  @override
  State<FbStoryScreen> createState() => _FbStoryScreenState();
}

const _containerHeight = 150.0;
const _containerWidht = 150.0;

class _FbStoryScreenState extends State<FbStoryScreen> {
  late ScrollController _controller;
  double _offset = 0;

  void _listen() {
    _offset = _controller.offset;
    setState(() {});
  }

  @override
  void initState() {
    _controller = ScrollController()..addListener(_listen);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listen);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              SizedBox(
                height: _containerHeight,
                child: ListView.builder(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return index == 0
                        ? Container(width: _containerWidht)
                        : Container(
                            width: _containerWidht,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(books[index].image),
                                  fit: BoxFit.cover),
                            ),
                          );
                  },
                  itemCount: books.length,
                ),
              ),
              StoryItem(offset: _offset),
            ],
          ),
          const CounterWidget(),
        ],
      ),
    );
  }
}

class StoryItem extends StatelessWidget {
  const StoryItem({Key? key, required this.offset}) : super(key: key);
  final double offset;
  @override
  Widget build(BuildContext context) {
    final _offset = (offset / 140).clamp(0.0, 1.0);
    return Positioned(
      left: 0,
      top: lerpDouble(0, (_containerHeight / 2) - 20, _offset),
      height: lerpDouble(_containerHeight, 50, _offset),
      width: lerpDouble(_containerWidht - 10, 45, _offset),
      child: Container(
        padding: const EdgeInsets.all(5),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(lerpDouble(20, 0, _offset)!),
            right: Radius.circular(lerpDouble(20, 40, _offset)!),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(lerpDouble(10, 22, _offset)!,
                        lerpDouble(10, 22, _offset)!),
                    bottom: Radius.elliptical(lerpDouble(10, 22, _offset)!,
                        lerpDouble(10, 22, _offset)!),
                  ),
                  image: const DecorationImage(
                      image: AssetImage('assets/card_/jb.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            _offset > 0.1
                ? Container()
                : FittedBox(
                    child: Row(children: const [
                      Text('Add Story'),
                      Icon(Icons.add_a_photo_sharp)
                    ]),
                  ),
          ],
        ),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({Key? key}) : super(key: key);

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TweenAnimationBuilder(
          key: Key(counter.toString()),
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(seconds: 1),
          builder: (context, double val, child) {
            return Center(
              child: Stack(
                children: [
                  if (counter != 0)
                    Opacity(
                      opacity: 1 - val,
                      child: Transform.translate(
                        offset: Offset(val * 50.0, 0),
                        child: Text(
                          counter.toString(),
                          style: const TextStyle(fontSize: 26),
                        ),
                      ),
                    ),
                  Transform.translate(
                    offset: Offset(-50 * (1 - val), 0),
                    child: Text(
                      (counter + 1).toString(),
                      style: const TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        FloatingActionButton(
          child: const Icon(Icons.plus_one),
          onPressed: () => setState(() => counter++),
        ),
      ],
    );
  }
}
