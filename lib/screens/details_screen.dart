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
          Hero(
            tag: trip.title + trip.img,
            child: ClipRRect(
              child: Image.asset('assets/${trip.img}',
                  height: 360,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter),
            ),
          ),
          const SizedBox(height: 30),
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return ScaleTransition(
                scale: CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0.5, 1.0, curve: Curves.easeInCubic),
                ),
                child: child,
              );
            },
            child: ListTile(
              title: Text(
                trip.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey[800],
                ),
              ),
              subtitle: Text(
                  '${trip.nights} night stay for only \$${trip.price}',
                  style: const TextStyle(letterSpacing: 1)),
              trailing: const Heart(),
            ),
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
          const Expanded(child: CounterWidget())
        ],
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({Key? key}) : super(key: key);

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TweenAnimationBuilder(
          key: Key(counter.toString()),
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(seconds: 1),
          builder: (context, double val, child) {
            return Center(
              child: Stack(
                children: [
                  if (counter != 0)
                    Opacity(
                      opacity: 1 - val,
                      child: Transform.translate(
                        offset: Offset(val * 50.0, 0),
                        child: Text(
                          counter.toString(),
                          style: const TextStyle(fontSize: 26),
                        ),
                      ),
                    ),
                  Transform.translate(
                    offset: Offset(-50 * (1 - val), 0),
                    child: Text(
                      (counter + 1).toString(),
                      style: const TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        FloatingActionButton(
          child: const Icon(Icons.add_alert),
          onPressed: () => setState(() => counter++),
        ),
      ],
    );
  }
}

const String sss =
    'Our assortment includes 100% original products from leading electronics, fashion, beauty, and lifestyle brands. Especially for shoppers who do not have debit cards or credit cards, Hello Bazar provides a facility of online shopping with cash on delivery to your home.';
