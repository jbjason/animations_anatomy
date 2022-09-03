import 'package:animations_anatomy/models/book.dart';
import 'package:flutter/material.dart';

class StackCardScreen extends StatefulWidget {
  const StackCardScreen({Key? key}) : super(key: key);
  @override
  State<StackCardScreen> createState() => _StackCardScreenState();
}

class _StackCardScreenState extends State<StackCardScreen> {
  final _controller = PageController(initialPage: 0);
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_listener);
  }

  void _listener() => setState(() => _currentPage = _controller.page!);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 200,
            height: size.height * .7,
            child: _Cards(currentPage: _currentPage),
          ),
          PageView.builder(
            controller: _controller,
            scrollDirection:
                Axis.vertical, // Axis.horizontal for horizontal Scroll
            itemCount: books.length,
            itemBuilder: (context, i) => const SizedBox(),
          ),
        ],
      )),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    super.dispose();
  }
}

// Vertical Scrolling
class _Cards extends StatelessWidget {
  const _Cards({Key? key, required this.currentPage}) : super(key: key);
  final double currentPage;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrain) {
        final List<Widget> _list = [];
        final height = constrain.maxHeight - 20;
        final width = constrain.maxWidth - 20;
        const aspectRatio = 1.0;
        // cz aspectRatio 1 => width==cardHeight
        final intervalTop = (height - width) / 8;

        for (int i = 0; i < books.length; i++) {
          double _top = 0;
          final _currentPosition = -(currentPage - i);
          if (_currentPosition <= 0) {
            _top = intervalTop * 8 - (height * _currentPosition);
          } else {
            _top = intervalTop * (8 - _currentPosition);
          }
          _top = _top <= 0 ? 0 : _top;
          final _card = Positioned.directional(
            textDirection: TextDirection.ltr,
            start: 15.0 * _currentPosition,
            end: 15.0 * _currentPosition,
            top: _top,
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      width: 4, color: Colors.black.withOpacity(0.2)),
                  image: DecorationImage(
                      image: AssetImage(books[i].image), fit: BoxFit.cover),
                ),
                child: Center(
                  child: Text('JB Jason ${i + 1}',
                      style:
                          const TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            ),
          );
          _list.add(_card);
        }
        return Stack(children: _list.reversed.toList());
      },
    );
  }
}
