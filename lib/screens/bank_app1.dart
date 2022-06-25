import 'dart:ui';

import 'package:animations_anatomy/models/book.dart';
import 'package:flutter/material.dart';

class BankApp1 extends StatefulWidget {
  const BankApp1({Key? key}) : super(key: key);

  @override
  State<BankApp1> createState() => _BankApp1State();
}

class _BankApp1State extends State<BankApp1> {
  late final PageController _controller;
  double _value = 1, percent = 0.0;
  int _currentIndex = 1;
  @override
  void initState() {
    _controller = PageController(viewportFraction: 0.8, initialPage: 1);
    _controller.addListener(_listener);
    super.initState();
  }

  void _listener() => setState(() => _value = _controller.page!);

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          _animatedContainer(size),
          _pageView(size),
        ],
      ),
    );
  }

  Widget _animatedContainer(Size size) {
    return _currentIndex == 0 || _currentIndex == 1
        ? Positioned(
            top: _currentIndex == 1
                ? size.height * .32
                : lerpDouble(size.height * .32, 0, percent),
            height: _currentIndex == 1
                ? size.height * .36
                : lerpDouble(size.height * .36, size.height, percent),
            //width: lerpDouble(size.width * .7, size.width, percent),
            left: _currentIndex == 1 ? 20 : lerpDouble(20, 0, percent),
            right: _currentIndex == 1 ? 100 : lerpDouble(100, 0, percent),
            child: Container(color: const Color.fromARGB(255, 28, 45, 59)),
          )
        : Container();
  }

  Widget _pageView(Size size) => Positioned(
        top: size.height * .3,
        height: size.height * .4,
        width: size.width,
        child: Opacity(
          opacity: _currentIndex > 0 ? 1 : 1 - percent,
          child: PageView.builder(
            controller: _controller,
            itemCount: books.length,
            onPageChanged: (page) => setState(() => _currentIndex = page),
            itemBuilder: (context, index) {
              percent = (index - _value).clamp(0.0, 1);
              return BankAppItem(book: books[index], index: index);
            },
          ),
        ),
      );
}

class BankAppItem extends StatelessWidget {
  const BankAppItem({Key? key, required this.book, required this.index})
      : super(key: key);
  final Book book;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10),
      child:
          index == 0 ? Container() : Image.asset(book.image, fit: BoxFit.cover),
    );
  }
}
