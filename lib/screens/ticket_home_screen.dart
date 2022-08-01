import 'package:animations_anatomy/screens/ticket_sliding_cards.dart';
import 'package:animations_anatomy/screens/ticket_tabs.dart';
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
              children: const [
                SizedBox(height: 20),
                Header(),
                SizedBox(height: 40),
                TicketTabs(),
                SizedBox(height: 8),
                TicketSlidingCards(),
              ],
            ),
          ),
          const TicketBottomNav(),
        ],
      ),
    );
  }
}

class TicketBottomNav extends StatefulWidget {
  const TicketBottomNav({Key? key}) : super(key: key);
  @override
  State<TicketBottomNav> createState() => _TicketBottomNavState();
}

const _imageRightMargin = 15.0;
const _imageSmallSize = 55.0;

class _TicketBottomNavState extends State<TicketBottomNav> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: 110,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.deepPurple[100],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Stack(
          children: [
            const Positioned(
              top: 0,
              left: 20,
              child: Text('Booked Exhibition', style: TextStyle(fontSize: 16)),
            ),
            for (int i = 0; i < tickets.length; i++) _ticketItem(tickets[i], i),
            const Positioned(bottom: 20, right: 15, child: Icon(Icons.menu)),
          ],
        ),
      ),
    );
  }

  Widget _ticketItem(Ticket ticket, int index) {
    return Positioned(
      left: index * (_imageSmallSize + _imageRightMargin) + 20,
      bottom: 0,
      child: Container(
        width: _imageSmallSize,
        height: _imageSmallSize,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(20),
            left: Radius.circular(20),
          ),
          image: DecorationImage(
              image: AssetImage(ticket.image), fit: BoxFit.cover),
        ),
      ),
    );
  }
}

final List<Ticket> tickets = [
  Ticket(
      image: 'assets/extra_/steve.jpeg',
      title: 'Shenzhen GLOBAL DESIGN AWARD 2018',
      date: '4.20-30'),
  Ticket(
      image: 'assets/extra_/efe.jpg',
      title: 'Shenzhen GLOBAL DESIGN AWARD 2018',
      date: '4.20-30'),
  Ticket(
      image: 'assets/extra_/rodion.jpeg',
      title: 'Dawan District Guangdong Hong Kong',
      date: '4.28-31'),
];

class Ticket {
  final String image;
  final String title;
  final String date;

  Ticket({required this.image, required this.title, required this.date});
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
