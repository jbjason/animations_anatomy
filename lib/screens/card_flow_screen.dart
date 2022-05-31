import 'package:animations_anatomy/models/card_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class CardFlowScreen extends StatefulWidget {
  const CardFlowScreen({Key? key}) : super(key: key);
  @override
  State<CardFlowScreen> createState() => _CardFlowScreenState();
}

const backGradient =
    LinearGradient(colors: [Color(0xFF4b6889), Color(0xFF9FB4D2)]);

class _CardFlowScreenState extends State<CardFlowScreen> {
  late PageController _controller;
  double _page = 0.0;
  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.78, initialPage: 1);
    _controller.addListener(_listener);
  }

  void _listener() => setState(() => _page = _controller.page!);

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
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

  Widget _scaffold() => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Column(
              children: [
                const TopSearchContainer(),
                const SizedBox(height: 10),
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
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
                          child: CardFlowItemWidget(cardItem: cardFlows[index]),
                        ),
                      );
                    },
                    itemCount: cardFlows.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class CardFlowItemWidget extends StatelessWidget {
  const CardFlowItemWidget({Key? key, required this.cardItem})
      : super(key: key);
  final CardFlow cardItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Expanded(flex: 3, child: TopFlowWidget(cardItem: cardItem)),
          const Spacer(),
          Expanded(flex: 5, child: BottomFlowWidget(reviews: cardItem.reviews)),
        ],
      ),
    );
  }
}

class TopFlowWidget extends StatelessWidget {
  const TopFlowWidget({Key? key, required this.cardItem}) : super(key: key);
  final CardFlow cardItem;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(cardItem.image, fit: BoxFit.cover),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardItem.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                cardItem.price,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                cardItem.place,
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardItem.date,
                    style: const TextStyle(fontSize: 11, color: Colors.white),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.2)),
                    child: const Text('CheckIn'),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class BottomFlowWidget extends StatelessWidget {
  const BottomFlowWidget({Key? key, required this.reviews}) : super(key: key);
  final List<CardReview> reviews;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(backgroundImage: AssetImage(reviews[0].avatar)),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(reviews[0].title,
                          style: const TextStyle(fontSize: 13)),
                      Text(reviews[0].date,
                          style: const TextStyle(fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              reviews[0].subtitle,
              style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              reviews[0].details,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
            const SizedBox(height: 6),
            Expanded(child: Image.asset(reviews[3].image, fit: BoxFit.cover))
          ],
        ),
      ),
    );
  }
}

class TopSearchContainer extends StatelessWidget {
  const TopSearchContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 45,
      margin: const EdgeInsets.only(left: 20, right: 20),
      width: width,
      child: Row(
        children: [
          Container(
            width: width * .8,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color(0xFF9FB4D2)),
            child: Row(
              children: const [
                Icon(Icons.search_sharp),
                SizedBox(width: 10),
                Text('Search...')
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.settings_applications_rounded)
        ],
      ),
    );
  }
}
