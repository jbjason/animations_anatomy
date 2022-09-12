import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String text;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const ScreenTitle({Key? key, required this.text, required this.scaffoldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
