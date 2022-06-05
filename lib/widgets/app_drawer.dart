import 'package:animations_anatomy/screens/animation_/flow_screen.dart';
import 'package:animations_anatomy/screens/animation_/sliver1_screen.dart';
import 'package:animations_anatomy/screens/animation_/sliver2_screen.dart';
import 'package:animations_anatomy/screens/animation_/animated_list1.dart';
import 'package:animations_anatomy/screens/animation_/music_screen.dart';
import 'package:animations_anatomy/screens/card_flow1/card_flow1_screen.dart';
import 'package:animations_anatomy/screens/tap_bar_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      width: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Animated List1'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const AnimatedList1())),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Music Screen2'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const MusicScreen())),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Sliver Animation1'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const Sliver1Screen())),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Sliver Animation2'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const Sliver2Screen())),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Flow Widgets'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const FlowScreen())),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Card Flow1'),
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CardFlow1Screen())),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Sync TapBar'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const TapBarScreen())),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
