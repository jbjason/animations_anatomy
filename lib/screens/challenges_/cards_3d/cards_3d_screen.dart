import 'dart:math' as math;
import 'dart:ui';
import 'package:animations_anatomy/models/book.dart';
import 'package:animations_anatomy/screens/challenges_/cards_3d/cards_3d_details.dart';
import 'package:flutter/material.dart';

class Cards3dScreen extends StatelessWidget {
  const Cards3dScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: kToolbarHeight + 10,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: const Text('My Playlist',
                    style: TextStyle(color: Colors.black)),
                leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.menu, color: Colors.black)),
              ),
            ),
            const Expanded(flex: 4, child: Cards3dBody()),
            const SizedBox(height: 50),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(child: Text('Recently Played')),
                  Expanded(
                      child: ListView.builder(
                    itemExtent: 190,
                    scrollDirection: Axis.horizontal,
                    itemCount: books.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child:
                          Cards3dImage(card: books[books.length - index - 1]),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Cards3dBody extends StatefulWidget {
  const Cards3dBody({Key? key}) : super(key: key);
  @override
  State<Cards3dBody> createState() => _Cards3dBodyState();
}

class _Cards3dBodyState extends State<Cards3dBody>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _moveController;
  bool _isSelected = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        lowerBound: 0.15,
        upperBound: 0.6,
        duration: const Duration(milliseconds: 500));
    _moveController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _moveController.dispose();
    super.dispose();
  }

  Future _onCardSelected(Book card, int index) async {
    setState(() => _selectedIndex = index);
    _moveController.forward();
    await Navigator.of(context).push(
      PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: ((context, animation, secondaryAnimation) =>
              FadeTransition(
                  opacity: animation, child: Cards3dDetails(card: card)))),
    );
    _moveController.reverse(from: 1);
  }

  int _verticalUpdate(int index) {
    if (index == _selectedIndex) {
      return 0;
      // these below conditon is reverse cz we declared the listView as reversedList
    } else if (index < _selectedIndex) {
      return 1;
    } else {
      return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, _) => GestureDetector(
            onTap: () {
              if (!_isSelected) {
                _controller
                    .forward()
                    .whenComplete(() => setState(() => _isSelected = true));
              } else {
                _controller
                    .reverse()
                    .whenComplete(() => setState(() => _isSelected = false));
              }
            },
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, .001)
                ..rotateX(_controller.value),
              child: AbsorbPointer(
                absorbing: !_isSelected,
                child: Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth * .5,
                  color: Colors.white,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ...List.generate(
                        4,
                        (index) => Cards3dItem(
                          card: books[index],
                          percent: _controller.value,
                          height: constraints.maxHeight / 2,
                          index: index,
                          verticalUpdate: _verticalUpdate(index),
                          animation: _moveController,
                          onSelect: (Book book) {
                            _onCardSelected(book, index);
                          },
                        ),
                      ).reversed,
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Cards3dItem extends StatelessWidget {
  const Cards3dItem(
      {Key? key,
      required this.height,
      required this.index,
      required this.percent,
      required this.onSelect,
      required this.verticalUpdate,
      required this.card,
      required this.animation})
      : super(key: key);
  final double height, percent;
  final Book card;
  final int index, verticalUpdate;
  final Animation<double> animation;
  final ValueChanged<Book> onSelect;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: height + (-index * height / 2) * percent - height / 5,
      child: Opacity(
        opacity: verticalUpdate == 0 ? 1 : 1 - animation.value,
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, _) => Hero(
            tag: card.author + card.title,
            flightShuttleBuilder: (context, animation, heroFlightDirection,
                fromHeroContext, toHeroContext) {
              Widget _card;
              if (heroFlightDirection == HeroFlightDirection.push) {
                _card = fromHeroContext.widget;
              } else {
                _card = toHeroContext.widget;
              }
              return AnimatedBuilder(
                animation: animation,
                builder: (context, _) => Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, .001)
                    ..rotateX(lerpDouble(0.0, math.pi * 2, animation.value)!),
                  child: _card,
                ),
              );
            },
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, .001)
                ..translate(
                    0.0,
                    // verticalUpdate value giving the direction of where does unselected cards would go
                    verticalUpdate *
                        animation.value *
                        MediaQuery.of(context).size.height *
                        .7,
                    index * 50.0),
              child: GestureDetector(
                onTap: () => onSelect(card),
                child: SizedBox(
                  height: height,
                  child: Cards3dImage(card: card),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Cards3dImage extends StatelessWidget {
  const Cards3dImage({Key? key, required this.card}) : super(key: key);
  final Book card;
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      elevation: 10,
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.asset(card.image, fit: BoxFit.cover),
      ),
    );
  }
}
