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
  late final _controller;

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
          SizedBox(
            height: size.height * .6,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  bottom: 60,
                  child: Image.asset(travels[_currentImage].imageBack,
                      fit: BoxFit.cover),
                ),
                Positioned(
                  top: 40,
                  left: 0,
                  right: 0,
                  child: Text(travels[_currentImage].title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                Positioned.fill(
                  bottom: 60,
                  child: Image.asset(travels[_currentImage].imageFront,
                      fit: BoxFit.cover),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 130,
                  child: PageView.builder(
                    onPageChanged: (val) => setState(() => _currentImage = val),
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Image.asset(travels[index].imageBack,
                          fit: BoxFit.cover),
                    ),
                    itemCount: travels.length,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                const Text('Recommended'),
                _recommentItem(),
                _recommentItem(),
                _recommentItem(),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget _recommentItem() {
    return Container(
      height: 130,
      margin: const EdgeInsets.all(10),
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
