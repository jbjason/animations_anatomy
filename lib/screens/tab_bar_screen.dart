import 'package:animations_anatomy/widgets/tapbar_widgets/sync_concept_.dart';
import 'package:animations_anatomy/widgets/tapbar_widgets/top_tap_widget.dart';
import 'package:flutter/material.dart';

class TapBarScreen extends StatelessWidget {
  const TapBarScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
