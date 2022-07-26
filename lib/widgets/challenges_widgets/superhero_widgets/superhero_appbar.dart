import 'package:flutter/material.dart';

class SuperHeroAppbar extends StatelessWidget {
  const SuperHeroAppbar(
      {Key? key, required this.animation, required this.onTap})
      : super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    const _icon = Icon(Icons.arrow_back_ios_new, color: Colors.black);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Transform.translate(
          offset: Offset(0, -100.0 * animation.value),
          child: const Text('Movies', style: TextStyle(color: Colors.black)),
        ),
        leading: animation.value < 1.0
            ? IconButton(
                onPressed: () => Navigator.maybePop(context), icon: _icon)
            : IconButton(onPressed: onTap, icon: _icon),
      ),
    );
  }
}
