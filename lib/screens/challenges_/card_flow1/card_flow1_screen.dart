import 'package:animations_anatomy/constants/constants.dart';
import 'package:animations_anatomy/models/card_flow.dart';
import 'package:animations_anatomy/screens/challenges_/card_flow1/card_detail_screen.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/card_flow1/card_flow_item_widget.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/card_flow1/top_search_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class CardFlow1Screen extends StatefulWidget {
  const CardFlow1Screen({Key? key}) : super(key: key);
  @override
  State<CardFlow1Screen> createState() => _CardFlow1ScreenState();
}

class _CardFlow1ScreenState extends State<CardFlow1Screen> {
  late PageController _controller;
  double _page = 0.0;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.84);
    _controller.addListener(_listener);
  }

  void _listener() => setState(() => _page = _controller.page!);

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  void _onSwipe(CardFlow _card) {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
              opacity: animation, child: CardDetailScreen(cardFlow: _card));
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
            child: DecoratedBox(
                decoration: BoxDecoration(gradient: backGradient))),
        _scaffold(),
      ],
    );
  }

  Widget _scaffold() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(top: 35, bottom: 10),
        child: Column(
          children: [
            const TopSearchContainer(),
            const SizedBox(height: 20),
            Expanded(child: _pageView()),
          ],
        ),
      ),
    );
  }

  Widget _pageView() => PageView.builder(
        controller: _controller,
        onPageChanged: (val) => setState(() => currentPage = val),
        itemBuilder: (context, index) {
          final percent = (_page - index).abs().clamp(0.0, 1.0);
          // for this line left pageItem -1=hide thake & right pageItem visible
          final factor = _controller.position.userScrollDirection ==
                  ScrollDirection.forward
              ? 1.0
              : -1.0;
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(math.radians(45 * percent * factor)),
            child: Opacity(
              opacity: 1 - percent.clamp(0.0, 0.6),
              child: CardFlowItemWidget(
                cardItem: cardFlows[index],
                onSwipe: () => _onSwipe(cardFlows[index]),
                selectedPage: currentPage,
              ),
            ),
          );
        },
        itemCount: cardFlows.length,
      );
}
