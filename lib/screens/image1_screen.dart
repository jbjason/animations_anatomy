import 'package:animations_anatomy/constants/constants.dart';
import 'package:animations_anatomy/widgets/image1_widgets/back_images.dart';
import 'package:flutter/material.dart';

class Image1Screen extends StatefulWidget {
  const Image1Screen({Key? key}) : super(key: key);

  @override
  State<Image1Screen> createState() => _Image1ScreenState();
}

class _Image1ScreenState extends State<Image1Screen> {
  int _currentImage = 0;

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

  Widget _topImagesList(Size size) => SizedBox(
        height: size.height * .6,
        child: Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: BackImages(
                travel: travels[_currentImage],
                key: Key(travels[_currentImage].title),
                currentIndex: _currentImage,
              ),
            ),
            _pageView(size),
          ],
        ),
      );

  Widget _pageView(Size size) => Positioned(
        bottom: 0,
        left: 10,
        height: 130,
        width: size.width - 10,
        child: PageView.builder(
          padEnds: false,
          controller: PageController(viewportFraction: 0.4, initialPage: 1),
          itemBuilder: (context, index) => InkWell(
            onTap: () => setState(() => _currentImage = index),
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
              const SizedBox(height: 5),
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
