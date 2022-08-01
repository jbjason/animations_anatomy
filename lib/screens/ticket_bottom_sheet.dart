import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

const double minHeight = 120;
const double imageSmallSize = 44;
const double imageBigSize = 120;
const double imageStartMarginTop = 36;
const double imageEndMarginTop = 80;
const double imageVerticalSpacing = 24;
const double imageHorizontalSpacing = 16;

class ExhibitionBottomSheet extends StatefulWidget {
  const ExhibitionBottomSheet({Key? key}) : super(key: key);
  @override
  _ExhibitionBottomSheetState createState() => _ExhibitionBottomSheetState();
}

class _ExhibitionBottomSheetState extends State<ExhibitionBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double get maxHeight => MediaQuery.of(context).size.height;

  double get statusBarMargin =>
      lerp(20, 20 + MediaQuery.of(context).padding.top);

  double get itemBorderRadius => lerp(8, 24);

  double get iconLeftBorderRadius => itemBorderRadius;

  double get iconRightBorderRadius => lerp(8, 0);

  double get imageSize => lerp(imageSmallSize, imageBigSize);

  double iconTopMargin(int index) =>
      lerp(imageStartMarginTop,
          imageEndMarginTop + index * (imageVerticalSpacing + imageBigSize)) +
      statusBarMargin;

  double iconLeftMargin(int index) =>
      lerp(index * (imageHorizontalSpacing + imageSmallSize), 0);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double lerp(double min, double max) =>
      lerpDouble(min, max, _controller.value)!;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          height: lerp(minHeight, maxHeight),
          left: 0,
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: _toggle,
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              decoration: const BoxDecoration(
                color: Color(0xFF162A49),
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Stack(
                children: [
                  const Positioned(
                    right: 0,
                    bottom: 24,
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  Positioned(
                    top: statusBarMargin,
                    child: Text(
                      'Booked Exhibition',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: lerp(14, 24),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  for (CartItem cartItem in cartItems) _buildFullItem(cartItem),
                  for (CartItem cartItem in cartItems) _buildIcon(cartItem),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIcon(CartItem cartItem) {
    int index = cartItems.indexOf(cartItem);
    return Positioned(
      height: imageSize,
      width: imageSize,
      top: iconTopMargin(index),
      left: iconLeftMargin(index),
      child: ClipRRect(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(iconLeftBorderRadius),
          right: Radius.circular(iconRightBorderRadius),
        ),
        child: Image.asset(
          cartItem.assetName,
          fit: BoxFit.cover,
          alignment: Alignment(lerp(1, 0), 0),
        ),
      ),
    );
  }

  Widget _buildFullItem(CartItem cartItem) {
    int index = cartItems.indexOf(cartItem);
    return ExpandedCartItem(
      topMargin: iconTopMargin(index),
      leftMargin: iconLeftMargin(index),
      height: imageSize,
      isVisible: _controller.status == AnimationStatus.completed,
      borderRadius: itemBorderRadius,
      title: cartItem.title,
      date: cartItem.date,
    );
  }

  void _toggle() {
    final bool isOpen = _controller.status == AnimationStatus.completed;
    _controller.fling(velocity: isOpen ? -2 : 2);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value -= details.primaryDelta! / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity < 0.0) {
      _controller.fling(velocity: math.max(2.0, -flingVelocity));
    } else if (flingVelocity > 0.0) {
      _controller.fling(velocity: math.min(-2.0, -flingVelocity));
    } else {
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
    }
  }
}

class ExpandedCartItem extends StatelessWidget {
  final double topMargin;
  final double leftMargin;
  final double height;
  final bool isVisible;
  final double borderRadius;
  final String title;
  final String date;

  const ExpandedCartItem(
      {Key? key,
      required this.topMargin,
      required this.height,
      required this.isVisible,
      required this.borderRadius,
      required this.title,
      required this.date,
      required this.leftMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      left: leftMargin,
      right: 0,
      height: height,
      child: AnimatedOpacity(
        opacity: isVisible ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white,
          ),
          padding: EdgeInsets.only(left: height).add(const EdgeInsets.all(8)),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            Text(
              '1 ticket',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              date,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: <Widget>[
            Icon(Icons.place, color: Colors.grey.shade400, size: 16),
            Text(
              'Science Park 10 25A',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            )
          ],
        )
      ],
    );
  }
}

final List<CartItem> cartItems = [
  CartItem(
      'steve-johnson.jpeg', 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  CartItem('efe-kurnaz.jpg', 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  CartItem(
      'rodion-kutsaev.jpeg', 'Dawan District Guangdong Hong Kong', '4.28-31'),
];

class CartItem {
  final String assetName;
  final String title;
  final String date;

  CartItem(this.assetName, this.title, this.date);
}
