import 'package:flutter/material.dart';
import 'package:animations_anatomy/screens/challenges_/bank1_chlng/bank1_app_screen.dart';
import 'package:animations_anatomy/screens/challenges_/bank2_chlng/bank2_chlng_screen.dart';
import 'package:animations_anatomy/screens/challenges_/batman_chlng/batman_signin_screen.dart';
import 'package:animations_anatomy/screens/challenges_/bounce_nav_screen.dart';
import 'package:animations_anatomy/screens/challenges_/custom_paint_anim/custom_paint_screen.dart';
import 'package:animations_anatomy/screens/challenges_/drag_bottom/drag_bottom_screen.dart';
import 'package:animations_anatomy/screens/challenges_/sliver2_chlng/sliver2_screen.dart';
import 'package:animations_anatomy/screens/challenges_/cards_3d/cards_3d_screen.dart';
import 'package:animations_anatomy/screens/challenges_/card_flow1/card_flow1_screen.dart';
import 'package:animations_anatomy/screens/challenges_/hero_anim/hero_challange1.dart';
import 'package:animations_anatomy/screens/challenges_/stack_card_scren.dart';
import 'package:animations_anatomy/screens/challenges_/sync_tabbar/tab_bar_screen.dart';
import 'package:animations_anatomy/screens/challenges_/nav_bar/nav_bar1.dart';
import 'package:animations_anatomy/screens/challenges_/starbuck_/starbuck_challenge.dart';
import 'package:animations_anatomy/screens/challenges_/loading_balloon_chlng/loading_screen1.dart';
import 'package:animations_anatomy/screens/challenges_/coffe_chlng/coffee_chlng_home.dart';
import 'package:animations_anatomy/screens/challenges_/superhero_chlng/superhero_chlng_scree.dart';
import 'package:animations_anatomy/screens/challenges_/ticket_chlng/ticket_home_screen.dart';
import 'package:animations_anatomy/screens/challenges_/drawer2_chlng/drawer2_screen.dart';
import 'package:animations_anatomy/widgets/home_button.dart';
import 'package:animations_anatomy/widgets/home_title.dart';
import 'package:animations_anatomy/constants/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HomeTitle(title: 'CHALLENGES'),
              _challenges(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _challenges() => Column(
        children: const [
          HomeButton(title: 'Batman SignIn', route: BatmanSignInScreen()),
          HomeButton(title: 'Card Flow1', route: CardFlow1Screen()),
          HomeButton(title: 'Ticket Challenge', route: TicketHomeScreen()),
          HomeButton(title: 'Sync TapBar', route: TabBarScreen()),
          HomeButton(title: 'Bank1 Challenge', route: Bank1AppScreen()),
          HomeButton(title: 'Loading Animation', route: LoadingScreen1()),
          HomeButton(
              title: 'SuperHero Animation', route: SuperHeroChlngScreen()),
          HomeButton(title: 'Drawer2 Chlng', route: Drawer2Screen()),
          HomeButton(title: 'Custom Paint Anim', route: CustomPaintScreen()),
          HomeButton(title: 'Bouncy Nav Buttons', route: BounceNavScreen()),
          HomeButton(title: '3d Cards Animation', route: Cards3dScreen()),
          HomeButton(title: 'Drag Bottom Cart', route: DragBottomScreen()),
          HomeButton(title: 'Stacked Card', route: StackCardScreen()),
          HomeButton(title: 'Coffee Challenge', route: CoffeeChlngHome()),
          HomeButton(title: 'Starbuck Challenge', route: StarbuckChallenge()),
          HomeButton(title: 'Bank2 Challenge', route: BankChlng2Screen()),
          HomeButton(title: 'Animated NavBar1', route: NavBar1()),
          HomeButton(title: 'Hero Challenge1', route: HeroChallenge1()),
          HomeButton(title: 'Sliver Animation2', route: Sliver2Screen()),
        ],
      );
}
