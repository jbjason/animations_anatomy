import 'package:animations_anatomy/constants/constants.dart';
import 'package:flutter/material.dart';

class Image1Screen extends StatefulWidget {
  const Image1Screen({Key? key}) : super(key: key);

  @override
  State<Image1Screen> createState() => _Image1ScreenState();
}

class _Image1ScreenState extends State<Image1Screen>
    with SingleTickerProviderStateMixin {
  int _currentImage = 0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Column(
        children: [
          _topImagesList(size),
          _recommentList(size),
        ],
      ),
    );
  }

  Widget _topImagesList(Size size) => AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => child!,
        child: SizedBox(
          height: size.height * .6,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                left: -100.0 * _controller.value,
                right: -100.0 * (1 - _controller.value),
                bottom: 60,
                child: Image.asset(travels[_currentImage].imageBack,
                    fit: BoxFit.cover),
              ),
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                height: 80,
                child: Center(
                  child: Text(travels[_currentImage].title,
                      style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Positioned.fill(
                left: -100.0 * _controller.value,
                right: -100.0 * (1 - _controller.value),
                bottom: 60,
                child: Image.asset(travels[_currentImage].imageFront,
                    fit: BoxFit.cover),
              ),
              _pageView(size),
            ],
          ),
        ),
      );

  Widget _pageView(Size size) => Positioned(
        bottom: 0,
        left: 10,
        height: 130,
        width: size.width,
        child: PageView.builder(
          controller: PageController(viewportFraction: 0.4, initialPage: 0),
          onPageChanged: (val) => setState(() => _currentImage = val),
          itemBuilder: (context, index) => AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Container(
              width: 150,
              margin: const EdgeInsets.only(right: 10),
              child: Image.asset(travels[index].imageBack, fit: BoxFit.cover),
            ),
          ),
          itemCount: travels.length,
        ),
      );

  Widget _recommentList(Size size) => Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text('Recommended',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              _recommentItem(),
              _recommentItem(),
              _recommentItem(),
            ],
          ),
        ),
      );

  Widget _recommentItem() {
    return Container(
      height: 120,
      color: Colors.grey[800],
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: 160,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(travels[3].imageBack),
                    fit: BoxFit.cover)),
          ),
          Expanded(child: Center(child: Text(trips[1].title))),
        ],
      ),
    );
  }
}
