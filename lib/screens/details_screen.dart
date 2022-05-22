import 'package:animations_anatomy/models/trip.dart';
import 'package:animations_anatomy/widgets/home_widgets/heart.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  const Details({Key? key, required this.trip, required this.animation})
      : super(key: key);
  final Trip trip;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: const Offset(0, 0),
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: const Interval(0, 0.5, curve: Curves.easeOutCubic),
                  ),
                ),
                child: child,
              );
            },
            child: ClipRRect(
              child: Image.asset('assets/${trip.img}',
                  height: 360,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter),
            ),
          ),
          const SizedBox(height: 30),
          ListTile(
            title: Text(
              trip.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.grey[800],
              ),
            ),
            subtitle: Text('${trip.nights} night stay for only \$${trip.price}',
                style: const TextStyle(letterSpacing: 1)),
            trailing: const Heart(),
          ),
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return SlideTransition(
                position: Tween<Offset>(
                        begin: const Offset(1, 0), end: const Offset(0, 0))
                    .animate(CurvedAnimation(
                        parent: animation,
                        curve: const Interval(0.5, 1,
                            curve: Curves.easeOutCubic))),
                child: child,
              );
            },
            child: Container(
              color: Colors.grey[850],
              padding: const EdgeInsets.all(18),
              child: Text(sss,
                  style: TextStyle(color: Colors.grey[600], height: 1.4)),
            ),
          ),
        ],
      ),
    );
  }
}

const String sss =
    'Our assortment includes 100% original products from leading electronics, fashion, beauty, and lifestyle brands. Especially for shoppers who do not have debit cards or credit cards, Hello Bazar provides a facility of online shopping with cash on delivery to your home.';
