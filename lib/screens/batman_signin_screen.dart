import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class BatmanSignInScreen extends StatefulWidget {
  const BatmanSignInScreen({Key? key}) : super(key: key);
  @override
  State<BatmanSignInScreen> createState() => _BatmanSignInScreenState();
}

const _duration1 = Duration(seconds: 4);
const _duration2 = Duration(seconds: 6);

class _BatmanSignInScreenState extends State<BatmanSignInScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller1;
  late Animation<double> _batLogoAnim, _batLogoMoveAnim;
  late Animation<double> _buttonsMoveInAnim, _textOpacityAnim;
  late Animation<double> _batmanImageAnim;

  late AnimationController _controller2;
  late Animation<double> _moveAllAnim2;
  late Animation<double> _batmanMoveUpAnim2, _triangleImageAnim2;
  late Animation<double> _moveUpColumnAnim2;

  @override
  void initState() {
    _setFirstController();
    _setSecondController();
    super.initState();
  }

  void _setSecondController() {
    _controller2 = AnimationController(vsync: this, duration: _duration2);
    _moveAllAnim2 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.0, .25));
    _batmanMoveUpAnim2 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.35, .55));
    _triangleImageAnim2 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.65, .8));
    _moveUpColumnAnim2 = CurvedAnimation(
        parent: _controller2,
        curve: const Interval(.85, 1.0, curve: Curves.easeIn));
  }

  void _setFirstController() {
    _controller1 = AnimationController(vsync: this, duration: _duration1);
    _batLogoAnim = Tween(begin: 30.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller1, curve: const Interval(0.0, 0.35)));
    _batLogoMoveAnim =
        CurvedAnimation(parent: _controller1, curve: const Interval(.45, .55));
    _textOpacityAnim =
        CurvedAnimation(parent: _controller1, curve: const Interval(.5, .6));
    _batmanImageAnim = Tween(begin: 5.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller1, curve: const Interval(.65, 1)));
    _buttonsMoveInAnim = CurvedAnimation(
        parent: _controller1,
        curve: const Interval(.65, 1, curve: Curves.decelerate));

    _controller1.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller2.dispose();
    _controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: Listenable.merge([_controller1, _controller2]),
      builder: (context, _) => Scaffold(
        backgroundColor: const Color(0XFF100F0B),
        body: Stack(
          children: [
            // Batman Background
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: size.height * .45,
              child: Image.asset(
                'assets/batman_/batman_background.png',
                fit: BoxFit.cover,
              ),
            ),
            // Batman Image
            Positioned(
              left: -10,
              right: -10,
              top: 0,
              height: size.height * .6,
              child: Transform.translate(
                offset: Offset(0, 100 * (1 - _batmanMoveUpAnim2.value)),
                child: Transform.translate(
                    offset: Offset(0, 100.0 * _moveAllAnim2.value),
                    child: BatmanImageAnimation(animation: _batmanImageAnim)),
              ),
            ),
            // Batman Logo
            Positioned(
              top: size.height / 2.8,
              left: size.width / 2 - 100,
              height: 80,
              width: 200,
              child: Opacity(
                opacity: (1 - _moveAllAnim2.value),
                child: BatmanLogoAnimation(
                    animation1: _batLogoAnim, animation2: _batLogoMoveAnim),
              ),
            ),
            // Welcome Text & Buttons
            Positioned(
              left: 0,
              right: 0,
              top: size.height / 2,
              child: Opacity(
                opacity: (1 - _moveAllAnim2.value),
                child: Transform.translate(
                  offset: Offset(0, 150 * _moveAllAnim2.value),
                  child: Column(
                    children: [
                      // Welcome Text
                      BatmanWelcomeText(animation: _textOpacityAnim),
                      const SizedBox(height: 20),
                      // Buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 38),
                        child: YellowButtonAnimation(
                            onPressed: _onPressed,
                            animation: _buttonsMoveInAnim),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressed() => _controller2.forward(from: 0.0);
}

class BatmanLogoAnimation extends StatelessWidget {
  const BatmanLogoAnimation(
      {Key? key, required this.animation1, required this.animation2})
      : super(key: key);
  final Animation<double> animation1, animation2;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([animation1, animation2]),
      builder: (context, _) => Transform.translate(
        offset: Offset(0, 100 * (1 - animation2.value)),
        child: Transform.scale(
          scale: animation1.value,
          child: Image.asset('assets/batman_/batman_logo.png',
              fit: BoxFit.contain),
        ),
      ),
    );
  }
}

class BatmanImageAnimation extends StatelessWidget {
  const BatmanImageAnimation({Key? key, required this.animation})
      : super(key: key);
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => Transform.scale(
        scale: animation.value,
        child: Image.asset('assets/batman_/batman_alone.png',
            fit: BoxFit.fitHeight),
      ),
    );
  }
}

class BatmanWelcomeText extends StatelessWidget {
  const BatmanWelcomeText({Key? key, required this.animation})
      : super(key: key);
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final _val = animation.value;
        return Opacity(
          opacity: _val,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text('WELCOME TO',
                  style: TextStyle(fontSize: 22, color: Colors.white)),
              Text('GOTHAM CITY',
                  style: TextStyle(fontSize: 35, color: Colors.white)),
              Text('YOU NEED ACCESS TO ENTER CITY',
                  style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        );
      },
    );
  }
}

class YellowButtonAnimation extends StatelessWidget {
  const YellowButtonAnimation(
      {Key? key, required this.animation, required this.onPressed})
      : super(key: key);
  final VoidCallback onPressed;
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final _val = animation.value;
        return Opacity(
          opacity: _val,
          child: Transform.translate(
            offset: Offset(0, 150 * (1 - _val)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                YellowButton(onpress: () {}, text: 'LOGIN'),
                YellowButton(onpress: onPressed, text: 'SIGNUP'),
              ],
            ),
          ),
        );
      },
    );
  }
}

class YellowButton extends StatelessWidget {
  const YellowButton({Key? key, required this.onpress, required this.text})
      : super(key: key);
  final VoidCallback onpress;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onpress,
        child: Container(
          height: 55,
          color: const Color(0xFFFDE86A),
          child: Stack(
            children: [
              Center(
                child: Text(
                  text,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              if (text == 'LOGIN')
                Positioned(
                  right: 5,
                  child: Transform.rotate(
                    angle: vector.radians(-40),
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'assets/batman_/batman_logo.png',
                      height: 30,
                      width: 60,
                      color: Colors.black26,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              if (text != 'LOGIN')
                Positioned(
                  left: 5,
                  child: Transform.rotate(
                    angle: vector.radians(40),
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      'assets/batman_/batman_logo.png',
                      height: 30,
                      width: 60,
                      color: Colors.black26,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
