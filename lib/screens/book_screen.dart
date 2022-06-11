import 'package:animations_anatomy/models/book.dart';
import 'package:flutter/material.dart';

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
            child:
                Image.asset('assets/card_/background.png', fit: BoxFit.cover),
          ),
          // Positioned(
          //   child: AppBar(
          //     leading: InkWell(
          //         onTap: () => Navigator.pop(context),
          //         child: const Icon(Icons.arrow_back_ios_new)),
          //     title: const Text('Book Concept'),
          //   ),
          // ),
          Positioned(
            top: kToolbarHeight + 30,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<double>(
                valueListenable: _notifier,
                builder: (context, double value, _) {
                  return PageView.builder(
                    controller: _controller,
                    itemBuilder: (ctx, index) {
                      // 0.9 ,o.8 to 0.1, 0.0
                      final percent = (index - value).clamp(0.0, 1.0);
                      return Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 002)
                            ..rotateY(2 * percent)
                            ..scale(1 + percent)
                            ..translate(-size.width * .8 * percent),
                          child: BookItem(book: books[index]));
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class BookItem extends StatelessWidget {
  const BookItem({Key? key, required this.book}) : super(key: key);
  final Book book;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          book.image,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width * .8,
        ),
        const SizedBox(height: 20),
        Text(book.title),
        Text(book.author),
      ],
    );
  }
}
