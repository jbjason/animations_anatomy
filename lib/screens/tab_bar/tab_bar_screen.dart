import 'package:animations_anatomy/widgets/tapbar_widgets/sync_concept_.dart';
import 'package:animations_anatomy/widgets/tapbar_widgets/top_tap_widget.dart';
import 'package:flutter/material.dart';

class TapBarScreen extends StatelessWidget {
  const TapBarScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(
          children: const [
            TopTapWidget(),
            Expanded(child: SyncConcept()),
          ],
        ),
      ),
    );
  }
}
