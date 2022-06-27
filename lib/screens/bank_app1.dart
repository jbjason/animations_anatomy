import 'dart:ui';
import 'package:animations_anatomy/models/book.dart';
import 'package:flutter/material.dart';

class BankApp1 extends StatefulWidget {
  const BankApp1({Key? key}) : super(key: key);
  @override
  State<BankApp1> createState() => _BankApp1State();
}

class _BankApp1State extends State<BankApp1>
    with SingleTickerProviderStateMixin {
  late final PageController _controller;
  late AnimationController _animationController;
  double _value = 1;
  final bool _isExpand = false;

  @override
  void initState() {
    _controller = PageController(viewportFraction: 0.8, initialPage: 1);
    _controller.addListener(_listener);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    super.initState();
  }

  void _listener() => setState(() => _value = _controller.page!);

  @override
  void dispose() {
    _animationController.dispose();
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [_animatedContainer(size), _pageView(size)]),
      ),
    );
  }

  Widget _animatedContainer(Size size) {
    final bool _isOne = _value < 0.98, _isNotOne = _value > 1.38;
    final percent2 = (1 - _value).clamp(0.0, 1.0);
    return _isNotOne
        ? Container()
        : Positioned(
            top: _isOne
                ? lerpDouble(size.height * .32, 0, percent2)
                : size.height * .32,
            height: _isOne
                ? lerpDouble(size.height * .45, size.height, percent2)
                : size.height * .45,
            left: _isOne ? lerpDouble(20, 0, percent2) : 20,
            right: _isOne ? lerpDouble(200, 0, percent2) : 200,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 28, 45, 59),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          );
  }

  Widget _pageView(Size size) => Opacity(
        opacity: _value >= 1 ? 1 : (_value).clamp(0.0, 1),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _titleAnimation(size),
              SizedBox(
                height: size.height * .8,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: books.length,
                  itemBuilder: (context, index) =>
                      BankAppItem(book: books[index], index: index),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _titleAnimation(Size size) {
    const _updatePercent = 0.0;
    return GestureDetector(
        // onTap: () => ,
        child: BankAppTitle(height: size.height * .2));
  }
}

class BankAppItem extends StatelessWidget {
  const BankAppItem({Key? key, required this.book, required this.index})
      : super(key: key);
  final Book book;
  final int index;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return index == 0
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: size.height * .55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        image: AssetImage(book.image), fit: BoxFit.cover),
                  ),
                  child: const Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      '\$ 10346 ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/card_/jb1.jpg'),
                      ),
                      Expanded(
                        child: Text(
                          book.author,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      const Text(
                        '+36.00',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

class BankAppTitle extends StatelessWidget {
  const BankAppTitle({Key? key, required this.height}) : super(key: key);
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.grey[400]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: const [
              Text(
                'Hello ',
                style: TextStyle(fontSize: 20),
              ),
              Expanded(
                child: Text(
                  'Jb Jason',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/card_/jb.jpg'),
              )
            ],
          ),
          Image.asset('assets/extra_/down-arrow.png',
              height: 20, width: 40, fit: BoxFit.cover),
        ],
      ),
    );
  }
}
