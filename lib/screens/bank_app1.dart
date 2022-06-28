import 'dart:ui';
import 'package:animations_anatomy/models/book.dart';
import 'package:animations_anatomy/widgets/bank_app1/bank_app_item.dart';
import 'package:animations_anatomy/widgets/bank_app1/bank_app_title.dart';
import 'package:flutter/material.dart';

class BankApp1 extends StatefulWidget {
  const BankApp1({Key? key}) : super(key: key);
  @override
  State<BankApp1> createState() => _BankApp1State();
}

const _maxHeightTitle = 600.0;

class _BankApp1State extends State<BankApp1>
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
                  ? lerpDouble(size.height * .32, 0, percent2)
                  : lerpDouble(size.height * .32, size.height * .85,
                      _animationController.value),
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
                  itemBuilder: (context, index) {
                    final double percent = (index - _value).clamp(0.0, 1);
                    return BankAppItem(
                        book: books[index], index: index, percent: percent);
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
          final newHeight = _currentHeight - val.delta.dy;
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
            child: BankAppTitle(onTap: _startAnimation, isExpand: _isExpand),
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
