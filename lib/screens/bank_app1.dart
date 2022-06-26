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
  double _value = 1;

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
            child: _container(),
          );
  }

  Widget _pageView(Size size) => Opacity(
        opacity: _value >= 1 ? 1 : (_value).clamp(0.0, 1),
        child: PageView.builder(
          controller: _controller,
          itemCount: books.length,
          itemBuilder: (context, index) =>
              BankAppItem(book: books[index], index: index),
        ),
      );
  Container _container() => Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 28, 45, 59),
          borderRadius: BorderRadius.circular(30),
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
    final size = MediaQuery.of(context).size;
    return index == 0
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: size.height * .2,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[400]),
                  child: Row(
                    children: [
                      const Text(
                        'Hello ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Expanded(
                        child: Text(
                          book.author,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ),
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/card_/jb.jpg'),
                      )
                    ],
                  ),
                ),
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
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage('assets/card_/jb1.jpg'),
                        ),
                        Expanded(
                          child: Text(
                            book.title,
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
                ),
              ],
            ),
          );
  }
}
