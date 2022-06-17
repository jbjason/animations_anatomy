import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:animations_anatomy/models/trip.dart';
import 'package:flutter/material.dart';

class DiskChallenge2 extends StatefulWidget {
  const DiskChallenge2({Key? key}) : super(key: key);
  @override
  State<DiskChallenge2> createState() => _DiskChallenge2State();
}

class _DiskChallenge2State extends State<DiskChallenge2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isGrid = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Disk Challenge2'),
          actions: [
            InkWell(
              onTap: () async {
                _controller.status == AnimationStatus.completed
                    ? await _controller.reverse()
                    : await _controller.forward();
                setState(() => _isGrid = !_isGrid);
              },
              child: _isGrid
                  ? const Icon(Icons.grid_4x4_sharp, color: Colors.white)
                  : const Icon(Icons.stacked_line_chart, color: Colors.white),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return DiskItem(trip: trips[index], controller: _controller);
            },
            itemCount: trips.length,
          ),
        ),
      ),
    );
  }
}

class DiskItem extends StatelessWidget {
  const DiskItem({Key? key, required this.trip, required this.controller})
      : super(key: key);
  final Trip trip;
  final AnimationController controller;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      height: size.height * .18,
      width: size.width,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) => Positioned(
              left: 125 * controller.value,
              height: size.height * .18 - 10,
              child: Transform.rotate(
                  alignment: Alignment.center,
                  angle: vector.radians(360 * controller.value),
                  child:
                      Image.asset('assets/trip/disk_.png', fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            left: 0,
            width: 150,
            child: Image.asset(trip.img, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
