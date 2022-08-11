import 'package:flutter/material.dart';

class Drawer2ChlngScreen extends StatefulWidget {
  const Drawer2ChlngScreen({Key? key}) : super(key: key);
  @override
  State<Drawer2ChlngScreen> createState() => _Drawer2ChlngScreenState();
}

const _duration = Duration(milliseconds: 500);

class _Drawer2ChlngScreenState extends State<Drawer2ChlngScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _appBar(context),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisExtent: 200,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return TweenAnimationBuilder(
                    tween: Tween<double>(begin: 90, end: 0),
                    duration: _duration,
                    builder: (context, double val, _) {
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, .002)
                          ..rotateY(val),
                        child: Container(
                          color: Colors.black12,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/cards_/$index'),
                                fit: BoxFit.cover),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) => AppBar(
        title: const Text('Drawer2 Challenge'),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      );
}
