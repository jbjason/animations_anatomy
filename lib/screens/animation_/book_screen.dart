import 'dart:math';
import 'package:animations_anatomy/models/book.dart';
import 'package:flutter/material.dart';

// ! book Transform Animation
class BookScreen extends StatefulWidget {
  const BookScreen({Key? key}) : super(key: key);
  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final _controller = PageController();
  final _notifier = ValueNotifier(0.0);
  @override
  void initState() {
    super.initState();
    _controller.addListener(_listener);
  }

  void _listener() {
    _notifier.value = _controller.page!;
  }

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
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset('assets/card_/background.png',
                  fit: BoxFit.cover)),
          Positioned(
            height: kToolbarHeight + 20,
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.grey[800],
              leading: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios_new)),
              title: const Text('Book Concept'),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height,
            child: ValueListenableBuilder<double>(
              valueListenable: _notifier,
              builder: (context, double value, _) {
                return PageView.builder(
                  controller: _controller,
                  itemBuilder: (ctx, index) {
                    // 0.9 ,o.8 to 0.1, 0.0
                    final percent = (index - value).clamp(0.0, 1.0);
                    return BookItem(
                        book: books[index], percent: percent, size: size);
                  },
                  itemCount: books.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BookItem extends StatelessWidget {
  const BookItem(
      {Key? key, required this.book, required this.percent, required this.size})
      : super(key: key);
  final Book book;
  final Size size;
  final double percent;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              height: size.height * .6,
              width: size.width * .7,
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(5.0, 5.0),
                ),
              ]),
            ),
            Transform(
              alignment: Alignment.centerLeft,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..rotateY(pow(percent, 0.5) * 1.5)
                ..scale(1 + percent)
                ..translate(-size.width * percent),
              child: Image.asset(
                book.image,
                fit: BoxFit.cover,
                height: size.height * .6,
                width: size.width * .7,
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * .1),
        Opacity(
          opacity: 1 - percent,
          child: Column(
            children: [
              Text(book.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              Text(
                book.author,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
