import 'package:animations_anatomy/models/book.dart';
import 'package:animations_anatomy/screens/cards_3d_details.dart';
import 'package:flutter/material.dart';

class Cards3dScreen extends StatelessWidget {
  const Cards3dScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title:
              const Text('My Playlist', style: TextStyle(color: Colors.black)),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
        ),
        body: Column(
          children: [
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
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isSelected = false;
  late int _selectedCard;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        lowerBound: 0.15,
        upperBound: 0.5,
        duration: const Duration(milliseconds: 800));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future _onCardSelected(Book card, int index) async {
    setState(() => _selectedCard = index);
    await Navigator.of(context).push(
      PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: ((context, animation, secondaryAnimation) =>
              Cards3dDetails(card: card))),
    );
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
                    children: [
                      ...List.generate(
                        4,
                        (index) => Cards3dItem(
                          card: books[index],
                          percent: _controller.value,
                          height: constraints.maxHeight / 2,
                          index: index,
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
      required this.card})
      : super(key: key);
  final double height, percent;
  final Book card;
  final int index;
  final ValueChanged<Book> onSelect;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: height + (-index * height / 2) * percent - height / 5,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, .001)
          ..translate(0.0, 0.0, index * 50.0),
        child: InkWell(
          onTap: () => onSelect(card),
          child: SizedBox(
            height: height,
            child: Cards3dImage(card: card),
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
