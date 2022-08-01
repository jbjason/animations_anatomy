import 'package:animations_anatomy/widgets/challenges_widgets/ticket_chlng/ticket_bottom_nav.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/ticket_chlng/ticket_sliding_cards.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/ticket_chlng/ticket_tabs.dart';
import 'package:flutter/material.dart';

class TicketHomeScreen extends StatelessWidget {
  const TicketHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _header(),
                const SizedBox(height: 40),
                const TicketTabs(),
                const SizedBox(height: 8),
                const TicketSlidingCards(),
              ],
            ),
          ),
          const TicketBottomNav(),
        ],
      ),
    );
  }

  Widget _header() => const Padding(
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
