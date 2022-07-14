import 'package:animations_anatomy/screens/animation_/fb_story_screen.dart';
import 'package:animations_anatomy/screens/animation_/flow_screen.dart';
import 'package:animations_anatomy/screens/animation_/sliver1_screen.dart';
import 'package:animations_anatomy/screens/batman_signin_screen.dart';
import 'package:animations_anatomy/screens/challenges_/drag_bottom/drag_bottom_cart.dart';
import 'package:animations_anatomy/screens/challenges_/sliver2_screen.dart';
import 'package:animations_anatomy/screens/animation_/animated_list1.dart';
import 'package:animations_anatomy/screens/animation_/disk_challenge1.dart';
import 'package:animations_anatomy/screens/animation_/book_screen.dart';
import 'package:animations_anatomy/screens/challenges_/cards_3d/cards_3d_screen.dart';
import 'package:animations_anatomy/screens/challenges_/bank_app1.dart';
import 'package:animations_anatomy/screens/challenges_/card_flow1/card_flow1_screen.dart';
import 'package:animations_anatomy/screens/challenges_/disk_challenge2.dart';
import 'package:animations_anatomy/screens/challenges_/hero_anim/hero_challange1.dart';
import 'package:animations_anatomy/screens/challenges_/stacked_card_scren.dart';
import 'package:animations_anatomy/screens/challenges_/sync_tabbar/tab_bar_screen.dart';
import 'package:animations_anatomy/screens/challenges_/nav_bar/nav_bar1.dart';
import 'package:animations_anatomy/screens/challenges_/starbuck_/starbuck_challenge.dart';
import 'package:animations_anatomy/screens/challenges_/loading_screen1.dart';
import 'package:animations_anatomy/screens/challenges_/coffe_chlng/coffee_chlng_home.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      width: 250,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Divider(),
            Container(
              height: 50,
              color: Colors.grey[800],
              margin: const EdgeInsets.only(bottom: 5),
              alignment: Alignment.center,
              child: const Text(
                'Challenges',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Starbuck Challenge'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const StarbuckChallenge())),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Hero Challenge1'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const HeroChallenge1())),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Disk Challenge2'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const DiskChallenge2())),
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
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const TabBarScreen())),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Sliver Animation2'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const Sliver2Screen())),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Bank App1'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const BankApp1())),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Loading Animation'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LoadingScreen1())),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('3d Cards Animation'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const Cards3dScreen())),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Drag Bottom Cart'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const DragBottomCart())),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Stacked Card'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const StackedCardScreen())),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Stacked Card'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const StackedCardScreen())),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Coffee Challenge'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CoffeeChlngHome())),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Batman SignIn'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const BatmanSignInScreen())),
            ),
            const Divider(),
            /*
             Others Animation
            */
            Container(
              height: 50,
              color: Colors.grey[800],
              margin: const EdgeInsets.only(bottom: 5),
              alignment: Alignment.center,
              child: const Text(
                'Others',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Animated List1'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AnimatedList1())),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Music Screen2'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const DiskChallenge1())),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Sliver Animation1'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const Sliver1Screen())),
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
              title: const Text('Book Concept'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const BookScreen())),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Bottom NavBar1'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const NavBar1())),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Fb Story'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const FbStoryScreen())),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
