import 'package:animations_anatomy/screens/challenges_/drag_bottom/drag_app_drawer.dart';
import 'package:animations_anatomy/screens/challenges_/drag_bottom/drag_bottom_body.dart';
import 'package:flutter/material.dart';

class DragBottomScreen extends StatefulWidget {
  const DragBottomScreen({Key? key}) : super(key: key);
  @override
  State<DragBottomScreen> createState() => _DragBottomScreenState();
}

class _DragBottomScreenState extends State<DragBottomScreen> {
  bool isOpen = false;
  double xOffset = 0, yOffset = 0, scaleFactor = 1;

  void _openDrawer(
      bool _isOpen, double _xOffset, double _yOffset, double _scaleFactor) {
    isOpen = _isOpen;
    xOffset = _xOffset;
    yOffset = _yOffset;
    scaleFactor = _scaleFactor;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Stack(
          children: [
            // Drag AppDrawer
            DragAppDrawer(isOpen: isOpen),
            // Drag Body
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              transform: Matrix4.translationValues(xOffset, yOffset, 0)
                ..scale(scaleFactor),
              child: DragBottomBody(openDrawer: _openDrawer, isOpen: isOpen),
            ),
          ],
        ),
      ),
    );
  }
}
