import 'dart:ui';
import 'package:animations_anatomy/models/book.dart';
import 'package:flutter/material.dart';

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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                SizedBox(
                  height: _containerHeight,
                  child: ListView.builder(
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Container(
                              width: _containerWidht, color: Colors.white)
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
          ),
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
      height: lerpDouble(_containerHeight, 40, _offset),
      width: lerpDouble(_containerWidht - 10, 60, _offset),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          image: const DecorationImage(
              image: AssetImage('assets/card_/jb.jpg'), fit: BoxFit.cover),
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(lerpDouble(20, 0, _offset)!),
            right: Radius.circular(lerpDouble(20, 40, _offset)!),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Opacity(
              opacity: ((120 - offset) / 120).clamp(0.0, 1.0),
              child: FittedBox(
                child: Row(children: const [
                  Text('Add Story', style: TextStyle(color: Colors.white)),
                  Icon(Icons.add_a_photo_sharp, color: Colors.white)
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
