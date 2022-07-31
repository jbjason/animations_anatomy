import 'package:animations_anatomy/screens/ticket_sliding_cards.dart';
import 'package:animations_anatomy/screens/ticket_tabs.dart';
import 'package:flutter/material.dart';

class TicketHomeScreen extends StatelessWidget {
  const TicketHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 8),
                Header(),
                SizedBox(height: 40),
                TicketTabs(),
                SizedBox(height: 8),
                TicketSlidingCards(),
              ],
            ),
          ), //use this or ScrollableExhibitionSheet
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Text(
        'Shenzhen',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
