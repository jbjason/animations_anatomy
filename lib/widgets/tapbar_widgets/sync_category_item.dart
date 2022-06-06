import 'package:animations_anatomy/widgets/tapbar_widgets/sync_concept_.dart';
import 'package:flutter/material.dart';

class SyncCategoryItem extends StatelessWidget {
  const SyncCategoryItem({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: categoryHeight,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue[900],
          fontSize: 18,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
