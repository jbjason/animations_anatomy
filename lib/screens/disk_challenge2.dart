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
  int _count = 2;

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
    final size = MediaQuery.of(context).size;
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
                setState(() {
                  _isGrid = !_isGrid;
                  _count = _count != 2 ? 2 : 1;
                });
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
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _count,
                mainAxisSpacing: 5,
                mainAxisExtent: size.height * .16,
                crossAxisSpacing: 10),
            itemBuilder: (context, index) =>
                DiskItem(trip: trips[index], controller: _controller),
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
    return Stack(
      children: [
        AnimatedBuilder(
          animation: controller,
          builder: (context, child) => Positioned(
            left: 60 * controller.value,
            bottom: 5,
            child: Transform.rotate(
                alignment: Alignment.center,
                angle: vector.radians(360 * controller.value),
                child: Image.asset('assets/trip/disk_.png',
                    height: size.height * .16, fit: BoxFit.cover)),
          ),
        ),
        Positioned(
          left: 0,
          child: Image.asset(trip.img, fit: BoxFit.fitHeight, width: 120),
        ),
      ],
    );
  }
}
