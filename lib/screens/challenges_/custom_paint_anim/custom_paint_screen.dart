import 'package:animations_anatomy/screens/challenges_/custom_paint_anim/pick_skin.dart';
import 'package:flutter/material.dart';

class CustomPaintScreen extends StatefulWidget {
  const CustomPaintScreen({Key? key}) : super(key: key);
  @override
  State<CustomPaintScreen> createState() => _CustomPaintScreenState();
}

class _CustomPaintScreenState extends State<CustomPaintScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  PickSkin _currentSkin = skins.first, _lastSkin = skins.last;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        upperBound: 2,
        duration: const Duration(milliseconds: 600));
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          _appBar(context),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                    child: Image.asset(_lastSkin.image, fit: BoxFit.fill)),
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) => ClipPath(
                      clipper: _SkinClipper(
                          percent: _controller.value, skin: _currentSkin),
                      child: Image.asset(_currentSkin.image, fit: BoxFit.fill),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          _sliverGrid(),
        ],
      ),
      bottomNavigationBar: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  Widget _sliverGrid() => SizedBox(
        height: 200,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            mainAxisExtent: 50,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final skin = skins[index];
            return InkWell(
              onTap: () {
                setState(() => _currentSkin = skin);
                _controller.forward(from: 0.0).whenComplete(() {
                  setState(() => _lastSkin = _currentSkin);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: skin.skincolor,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: _currentSkin.image == skin.image
                          ? Colors.grey[700]!
                          : skin.skincolor,
                      width: 6),
                ),
              ),
            );
          },
          itemCount: skins.length,
        ),
      );

  Widget _appBar(BuildContext context) => AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.brightness_3),
          )
        ],
      );
}

class _SkinClipper extends CustomClipper<Path> {
  const _SkinClipper({required this.percent, required this.skin});
  final double percent;
  final PickSkin skin;
  @override
  Path getClip(Size size) {
    final height = size.height, width = size.width;
    final path = Path();
    Offset center = Offset.zero;
    // set center . topLeft_corner=(x,y)=(0,0)  topRight_corner=(x,y)=(width,0)
    if (skin.skinAlign == Alignment.topLeft) {
      center = const Offset(0, 0);
    } else if (skin.skinAlign == Alignment.topRight) {
      center = Offset(width, 0);
    } else if (skin.skinAlign == Alignment.center) {
      center = Offset(width / 2, height / 2);
    } else if (skin.skinAlign == Alignment.centerRight) {
      center = Offset(width, height / 2);
    } else if (skin.skinAlign == Alignment.centerLeft) {
      center = Offset(0, height / 2);
    } else if (skin.skinAlign == Alignment.bottomRight) {
      center = Offset(width, height);
    } else {
      // ceterBottom
      center = Offset(width / 2, height);
    }
    path.addOval(Rect.fromCenter(
        center: center, width: width * percent, height: height * percent));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
