import 'package:animations_anatomy/models/trip.dart';
import 'package:flutter/material.dart';

class HeroDetails1 extends StatefulWidget {
  const HeroDetails1({Key? key, required this.travel}) : super(key: key);
  final Trip travel;
  @override
  State<HeroDetails1> createState() => _HeroDetails1State();
}

class _HeroDetails1State extends State<HeroDetails1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
        reverseCurve: Curves.easeInOutBack));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: size.height * .83,
              width: size.width,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, _) => Transform(
                  //  origin: const Offset(-70, -70),
                  transform: Matrix4.identity()
                    ..rotateZ(-1.6 * _animation.value),
                  alignment: Alignment.center,
                  child: Image.asset(widget.travel.img, fit: BoxFit.fitHeight),
                ),
              ),
            ),
            // const SizedBox(height: 40),
            // Center(
            //   child: Text(
            //     widget.travel.title,
            //     style:
            //         const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // const SizedBox(height: 40),
            // const Text(
            //   '$detailsText\n$detailsText',
            //   style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            // ),
            Positioned(
              top: 10,
              left: 20,
              child: IconButton(
                onPressed: () async {
                  await _controller.reverse();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
