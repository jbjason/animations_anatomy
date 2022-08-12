import 'dart:math' as math;
import 'dart:ui';
import 'package:animations_anatomy/screens/challenges_/drawer2_chlng/drawer2_itemlist.dart';
import 'package:flutter/material.dart';

const _duration2 = Duration(milliseconds: 500);
const _duration = Duration(milliseconds: 1500);

class Drawer2Screen extends StatefulWidget {
  const Drawer2Screen({Key? key}) : super(key: key);
  @override
  State<Drawer2Screen> createState() => _Drawer2ScreenState();
}

class _Drawer2ScreenState extends State<Drawer2Screen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration2);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [const SizedBox(height: 60), _gridView()],
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => Positioned(
                height: size.height,
                width: lerpDouble(-size.width, size.width, _controller.value),
                child: Container(color: Colors.blue[300]),
              ),
            ),
            _appBar(context),
          ],
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) => AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Drawer2 Challenge',
            style: TextStyle(color: Colors.brown)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            await _controller.forward(from: 0.0);
            Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: _duration2,
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const Drawer2ItemsScreen()));
          },
          icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              color: Colors.brown,
              progress: _controller),
        ),
      );

  Widget _gridView() => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisExtent: 250,
              mainAxisSpacing: 20,
            ),
            itemCount: 8,
            itemBuilder: (context, index) {
              return TweenAnimationBuilder(
                tween: Tween<double>(begin: -math.pi / 2, end: 0),
                duration: _duration,
                builder: (context, double val, _) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(val),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/card_/${1 + index}.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
