import 'package:flutter/material.dart';

class BounceNavScreen extends StatelessWidget {
  const BounceNavScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Jb Jason')),
      bottomNavigationBar: _NavBar(),
    );
  }
}

class _NavBar extends StatefulWidget {
  const _NavBar({Key? key}) : super(key: key);
  @override
  State<_NavBar> createState() => __NavBarState();
}

const _shrinkVal = 75.0;
const _iconList = [Icons.home, Icons.mail, Icons.people, Icons.backpack];

class __NavBarState extends State<_NavBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _navMoveIn, _navMoveOut;
  late Animation<double> _circleAnim;
  late Animation<double> _iconToTop, _iconToBottom;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _navMoveIn = CurvedAnimation(
        parent: _controller,
        curve: const Interval(.1, .6, curve: Curves.decelerate));
    _iconToTop = CurvedAnimation(
        parent: _controller,
        curve: const Interval(.3, .6, curve: Curves.slowMiddle));
    _circleAnim = CurvedAnimation(
        parent: _controller,
        curve: const Interval(.35, .5, curve: Curves.slowMiddle));
    _iconToBottom = CurvedAnimation(
        parent: _controller,
        curve: const Interval(.6, .95, curve: Curves.bounceOut));
    _navMoveOut = CurvedAnimation(
        parent: _controller,
        curve: const Interval(.6, 1, curve: Curves.bounceOut));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          double _width = size.width -
              (_shrinkVal * _navMoveIn.value) +
              (_shrinkVal * _navMoveOut.value);
          double _bounceAnim =
              -80 * _iconToTop.value + 60 * _iconToBottom.value;
          return Center(
            child: Container(
              width: _width,
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  _iconList.length * 2,
                  (index) => Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _currentIndex = index);
                        _controller.forward(from: 0.0);
                      },
                      child: _currentIndex == index
                          ? CustomPaint(
                              foregroundPainter:
                                  _NavClipper(circleAnim: _circleAnim.value),
                              child: Transform.translate(
                                offset: Offset(0.0, _bounceAnim),
                                child: _iconBody(index % 4),
                              ),
                            )
                          : _iconBody(index % 4),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _iconBody(int i) => CircleAvatar(
        radius: 30,
        backgroundColor: Colors.deepPurple,
        child: Icon(_iconList[i], color: Colors.white),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _NavClipper extends CustomPainter {
  const _NavClipper({required this.circleAnim});
  final double circleAnim;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final _radius = 20 * circleAnim;
    final _strokeWidth = 10 * (1 - circleAnim);
    final paint = Paint()
      ..strokeWidth = _strokeWidth
      ..color = Colors.black
      ..style = PaintingStyle.stroke;
    if (circleAnim < 1) canvas.drawCircle(center, _radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
