import 'package:animations_anatomy/constants/constants.dart';
import 'package:flutter/material.dart';

// items scale to 0 while scalling
class AnimatedList1 extends StatefulWidget {
  const AnimatedList1({Key? key}) : super(key: key);

  @override
  State<AnimatedList1> createState() => _AnimatedList1State();
}

const itemSize = 200.0;

class _AnimatedList1State extends State<AnimatedList1> {
  final _controller = ScrollController();
  double currentOffset = 0;

  void _listen() {
    setState(() {
      currentOffset = _controller.offset;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_listen);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_listen);
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          const SliverToBoxAdapter(
            child: Placeholder(fallbackHeight: 100, color: Colors.transparent),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final itemOffset = index * itemSize;
                final difference = currentOffset - (itemOffset / 2);
                double percent = 1 - (difference / (itemSize / 2));
                double scale = percent;
                if (percent > 1.0) percent = 1.0;
                if (percent < 0.0) percent = 0.0;
                if (scale > 1.0) scale = 1.0;
                return Align(
                  heightFactor: 0.8,
                  child: Opacity(
                    opacity: percent,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..scale(scale, scale),
                      child: Container(
                        height: itemSize,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            border: Border.all(color: Colors.grey[800]!),
                            color: Colors.grey[300]),
                        child: Row(
                          children: [
                            Image.asset('assets/${trips[index].img}',
                                width: 200, fit: BoxFit.cover),
                            Expanded(
                              child: Center(
                                  child: Text(trips[index].title,
                                      style: const TextStyle(fontSize: 23))),
                            ),
                            Text(trips[index].price),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: trips.length,
            ),
          ),
        ],
      ),
    );
  }
}
