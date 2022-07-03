import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String text;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const ScreenTitle({Key? key, required this.text, required this.scaffoldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 1, end: 0),
      duration: const Duration(seconds: 1),
      builder: (context, double val, Widget? child) => Transform(
        transform: Matrix4.identity()..translate(val * 200, val * 200),
        alignment: Alignment.center,
        child: child,
      ),
      child: Row(
        children: [
          InkWell(
              onTap: () => scaffoldKey.currentState!.openDrawer(),
              child: const Icon(Icons.menu_sharp, size: 25)),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
