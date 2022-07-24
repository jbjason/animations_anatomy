import 'package:animations_anatomy/widgets/challenges_widgets/batman_widgets/batman_clipper.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/batman_widgets/batman_image_anim.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/batman_widgets/batman_logo_anim.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/batman_widgets/batman_welcome_text.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/batman_widgets/signup_widgets.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/batman_widgets/yellow_button_anim.dart';
import 'package:flutter/material.dart';

class BatmanSignInScreen extends StatefulWidget {
  const BatmanSignInScreen({Key? key}) : super(key: key);
  @override
  State<BatmanSignInScreen> createState() => _BatmanSignInScreenState();
}

const _duration1 = Duration(seconds: 4);
const _duration2 = Duration(seconds: 6);

class _BatmanSignInScreenState extends State<BatmanSignInScreen>
    with TickerProviderStateMixin {
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

    return Scaffold(
      backgroundColor: const Color(0XFF100F0B),
      body: AnimatedBuilder(
        animation: Listenable.merge([_controller1, _controller2]),
        builder: (context, _) => Stack(
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
              top: -size.height * .1,
              height: size.height * .6,
              child: Transform.translate(
                offset: Offset(0, 100 * (1 - _batmanMoveUpAnim2.value)),
                child: Transform.translate(
                    offset: Offset(0, 100 * _moveAllAnim2.value),
                    child: BatmanImageAnim(animation: _batmanImageAnim)),
              ),
            ),
            // Triangle City-Image
            Positioned(
              top: size.height / 3.9,
              left: 40,
              right: 40,
              child: ClipPath(
                clipper: BatmanClipper(progress: _triangleImageAnim2.value),
                child:
                    Image.asset('assets/batman_/city.png', fit: BoxFit.contain),
              ),
            ),
            // SignUp Widgets
            Positioned(
              top: size.height * .53,
              left: 0,
              right: 0,
              bottom: 0,
              child: SignUpWidgets(
                animation: _moveUpColumnAnim2,
                onTap: _reverseSignUpAnimation,
              ),
            ),
            // Batman Logo
            Positioned(
              top: size.height / 3,
              left: size.width / 2 - 100,
              height: 80,
              width: 200,
              child: Opacity(
                opacity: (1 - _moveAllAnim2.value),
                child: BatmanLogoAnim(
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
                          onPressed: _startSignUpAnimation,
                          animation: _buttonsMoveInAnim,
                        ),
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

  void _reverseSignUpAnimation() => _controller2.reverse(from: 1.0);
  void _startSignUpAnimation() => _controller2.forward(from: 0.0);
}
