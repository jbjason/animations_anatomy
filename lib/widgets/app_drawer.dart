import 'package:animations_anatomy/screens/sliver1_screen.dart';
import 'package:animations_anatomy/screens/sliver2_screen.dart';
import 'package:animations_anatomy/screens/sliver_list1.dart';
import 'package:animations_anatomy/screens/music_screen.dart';
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
                .push(MaterialPageRoute(builder: (_) => const SliverList1())),
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
        ],
      ),
    );
  }
}
