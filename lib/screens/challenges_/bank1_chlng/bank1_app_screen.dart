import 'dart:ui';
import 'package:animations_anatomy/models/book.dart';
import 'package:animations_anatomy/screens/challenges_/bank1_chlng/bank1_animated_page.dart';
import 'package:animations_anatomy/screens/challenges_/bank1_chlng/bank1_app_item.dart';
import 'package:animations_anatomy/screens/challenges_/bank1_chlng/bank1_app_title.dart';
import 'package:flutter/material.dart';

const _maxHeightTitle = 650.0;

class Bank1AppScreen extends StatefulWidget {
  const Bank1AppScreen({Key? key}) : super(key: key);
  @override
  State<Bank1AppScreen> createState() => _Bank1AppScreenState();
}

class _Bank1AppScreenState extends State<Bank1AppScreen>
    with SingleTickerProviderStateMixin {
  late final PageController _controller;
  late AnimationController _animationController;
  double _value = 1, _currentHeight = 0.0;
  bool _isExpand = false;

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
        : AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) => Positioned(
              top: _isOne
                  ? lerpDouble(size.height * .3, 0, percent2)
                  : lerpDouble(size.height * .3, size.height * .85,
                      _animationController.value),
              left: _isOne ? lerpDouble(15, 0, percent2) : 15,
              child: Container(
                height: _isOne
                    ? lerpDouble(size.height * .5, size.height, percent2)
                    : size.height * .5,
                width: _isOne ? lerpDouble(300, size.width, percent2) : 300,
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius:
                      BorderRadius.circular(lerpDouble(60, 0, percent2)!),
                ),
                child: Opacity(
                    opacity: percent2, child: const Bank1AnimatedPage()),
              ),
            ),
          );
  }

  Widget _pageView(Size size) => Opacity(
        opacity: _value >= 1 ? 1 : (_value).clamp(0.0, 1),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _titleAnimation(size),
              SizedBox(
                height: size.height * .77,
                child: PageView.builder(
                  // onPageChanged: (val) => setState(() => _currentIndex = val),
                  controller: _controller,
                  itemCount: books.length - 2,
                  itemBuilder: (context, index) {
                    final percent = _value - index;
                    return Bank1AppItem(
                        isSelect: _value == index,
                        book: books[index + 1],
                        index: index,
                        percent: percent);
                  },
                ),
              ),
            ],
          ),
        ),
      );

  Widget _titleAnimation(Size size) {
    final _minHeight = size.height * .2;
    return GestureDetector(
      onVerticalDragUpdate: (val) {
        if (!_isExpand) return;
        setState(() {
          // here _currentHeight = maxHeight ,we declared already
          //(-val.delta.dy) gives bottom to top drag value
          final newHeight = _currentHeight - (-val.delta.dy);
          _currentHeight = newHeight.clamp(_minHeight, _maxHeightTitle);
          _animationController.value = _currentHeight / _maxHeightTitle;
        });
      },
      onVerticalDragEnd: (val) {
        if (!_isExpand) return;
        if (_currentHeight < _maxHeightTitle / 2) {
          _animationController.reverse();
          _isExpand = false;
        } else {
          _animationController.forward(from: _currentHeight / _maxHeightTitle);
          _currentHeight = _maxHeightTitle;
          _isExpand = true;
        }
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          final value = _animationController.value;
          return Container(
            height: lerpDouble(_minHeight, _maxHeightTitle, value)!,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            margin: EdgeInsets.all(lerpDouble(20, 0, value)!),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[200]),
            child: Bank1AppTitle(onTap: _startAnimation, isExpand: _isExpand),
          );
        },
      ),
    );
  }

  void _startAnimation() {
    setState(() {
      _isExpand = true;
      _currentHeight = _maxHeightTitle;
    });
    _animationController.forward(from: 0.0);
  }
}
