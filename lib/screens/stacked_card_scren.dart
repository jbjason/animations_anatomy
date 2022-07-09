import 'dart:ui';

import 'package:animations_anatomy/models/book.dart';
import 'package:flutter/material.dart';

class StackedCardScreen extends StatelessWidget {
  const StackedCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stacked Card'),
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(Icons.menu)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: PerspectiveListView(
        (value) {},
        (value) {},
        visualizedItem: 8,
        initialIndex: 7,
        itemExtend: size.height * .33,
        backItemShadowColor: Colors.grey[800]!,
        padding: const EdgeInsets.all(10),
        children: List.generate(
          books.length,
          (index) {
            final contact = books[index];
            final borderColor = Colors.accents[index % Colors.accents.length];
            return ContactCard(borderColor: borderColor, contact: contact);
          },
        ),
      ),
    );
  }
}

class PerspectiveListView extends StatefulWidget {
  const PerspectiveListView(
    this.onTapFrontItem,
    this.onChangeItem, {
    Key? key,
    required this.children,
    required this.itemExtend,
    required this.visualizedItem,
    this.initialIndex = 0,
    this.padding = const EdgeInsets.all(0.0),
    this.backItemShadowColor = Colors.black,
  }) : super(key: key);
  final List<Widget> children;
  final double itemExtend;
  final int visualizedItem, initialIndex;
  final EdgeInsetsGeometry padding;
  final ValueChanged<int> onTapFrontItem, onChangeItem;
  final Color backItemShadowColor;

  @override
  State<PerspectiveListView> createState() => _PerspectiveListViewState();
}

class _PerspectiveListViewState extends State<PerspectiveListView> {
  late PageController _pageController;
  late double _pagePercent;
  late int _currentIndex;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: widget.initialIndex,
      viewportFraction: 1 / widget.visualizedItem,
    );
    _currentIndex = widget.initialIndex;
    _pagePercent = 0.0;
    _pageController.addListener(_pageListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  void _pageListener() {
    _currentIndex = _pageController.page!.floor();
    _pagePercent = (_pageController.page! - _currentIndex).abs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // perspective item
        Padding(
          padding: widget.padding,
          child: _PerspectiveListItem(
            heightItem: widget.itemExtend,
            currentIndex: _currentIndex,
            generateItems: widget.visualizedItem - 1,
            children: widget.children,
            pagePercent: _pagePercent,
          ),
        ),
        //void page View
        PageView.builder(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          controller: _pageController,
          onPageChanged: (val) {
            if (widget.onChangeItem.toString().isEmpty) {
              widget.onChangeItem(val);
            }
          },
          itemCount: widget.children.length,
          itemBuilder: (context, index) {
            return const SizedBox();
          },
        )
      ],
    );
  }
}

class _PerspectiveListItem extends StatelessWidget {
  const _PerspectiveListItem(
      {Key? key,
      required this.generateItems,
      required this.currentIndex,
      required this.heightItem,
      required this.pagePercent,
      required this.children})
      : super(key: key);

  final int generateItems, currentIndex;
  final double heightItem, pagePercent;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        return Stack(
          fit: StackFit.expand,
          children: List.generate(generateItems, (index) {
            final invertedIndex = (generateItems - 2) - index;
            final indexPlus = index + 1;
            final positionedPercent = indexPlus / generateItems;
            final endPositionPercent = index / generateItems;
            return (currentIndex > invertedIndex)
                ? _TransformedItem(
                    child: children[currentIndex - (invertedIndex + 1)],
                    heightItem: heightItem,
                    factorChange: pagePercent,
                    scale: lerpDouble(.5, 1.0, positionedPercent)!,
                    endScale: lerpDouble(.5, 1.0, endPositionPercent)!,
                    translateY: (height - heightItem) + positionedPercent,
                    endTranslateY: (height - heightItem) + endPositionPercent,
                  )
                : const SizedBox();
          }),
        );
      },
    );
  }
}

class _TransformedItem extends StatelessWidget {
  const _TransformedItem(
      {Key? key,
      required this.child,
      required this.heightItem,
      required this.factorChange,
      this.scale = 1.0,
      this.endScale = 1.0,
      this.translateY = 0.0,
      this.endTranslateY = 0.0})
      : super(key: key);
  final Widget child;
  final double heightItem, factorChange;
  final double scale, endScale;
  final double translateY, endTranslateY;
  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.topCenter,
      transform: Matrix4.identity()
        ..scale(lerpDouble(scale, endScale, factorChange))
        ..translate(
            0.0, lerpDouble(translateY, endTranslateY, factorChange)!, 0.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: heightItem,
          child: child,
          width: double.infinity,
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  const ContactCard(
      {Key? key, required this.borderColor, required this.contact})
      : super(key: key);
  final Color borderColor;
  final Book contact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          heightFactor: .9,
          alignment: Alignment.centerLeft,
          child: Container(
            height: 70,
            width: 30,
            decoration: BoxDecoration(
              color: borderColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: borderColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.people, size: 40),
                      const SizedBox(width: 10),
                      Text(contact.title),
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(Icons.home, size: 40),
                      SizedBox(width: 10),
                      Text('1 Character '),
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(Icons.phone, size: 40),
                      SizedBox(width: 10),
                      Text('01628430948'),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.mail_sharp, size: 40),
                      const SizedBox(width: 10),
                      Text(contact.author, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
