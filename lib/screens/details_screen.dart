import 'package:animations_anatomy/models/trip.dart';
import 'package:animations_anatomy/widgets/home_widgets/heart.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  const Details({Key? key, required this.trip}) : super(key: key);
  final Trip trip;

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
          ClipRRect(
            child: Image.asset('images/${trip.img}',
                height: 360, fit: BoxFit.cover, alignment: Alignment.topCenter),
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
          Padding(
            padding: const EdgeInsets.all(18),
            child: Text('',
                style: TextStyle(color: Colors.grey[600], height: 1.4)),
          ),
        ],
      ),
    );
  }
}
