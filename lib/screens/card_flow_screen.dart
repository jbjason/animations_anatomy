import 'package:animations_anatomy/models/card_flow.dart';
import 'package:flutter/material.dart';

class CardFlowScreen extends StatefulWidget {
  const CardFlowScreen({Key? key}) : super(key: key);
  @override
  State<CardFlowScreen> createState() => _CardFlowScreenState();
}

const backGradient =
    LinearGradient(colors: [Color(0xFF4b6889), Color(0xFF9FB4D2)]);

class _CardFlowScreenState extends State<CardFlowScreen> {
  late PageController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.8, initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
            child: DecoratedBox(
                decoration: BoxDecoration(gradient: backGradient))),
        SafeArea(
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
                      itemBuilder: (context, index) =>
                          CardFlowItemWidget(cardItem: cardFlows[index]),
                      itemCount: cardFlows.length,
                    ),
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

class CardFlowItemWidget extends StatelessWidget {
  const CardFlowItemWidget({Key? key, required this.cardItem})
      : super(key: key);
  final CardFlow cardItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 3, child: TopFlowWidget(cardItem: cardItem)),
        const Spacer(),
        Expanded(flex: 5, child: BottomFlowWidget(reviews: cardItem.reviews)),
      ],
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
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                cardItem.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    cardItem.place,
                    style: TextStyle(
                        fontSize: 13, color: Colors.white.withOpacity(0.7)),
                  ),
                  Text(
                    cardItem.date,
                    style: TextStyle(
                        fontSize: 11, color: Colors.white.withOpacity(0.6)),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.7)),
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
    return Card(
      elevation: 10,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundImage: AssetImage(reviews[0].avatar)),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              reviews[0].details,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Expanded(child: Image.asset(reviews[0].image, fit: BoxFit.cover))
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
      height: 50,
      margin: const EdgeInsets.only(left: 20, right: 20),
      width: width,
      child: Row(
        children: [
          Container(
            width: width * .8,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color(0xFF8E9885)),
            child: Row(
              children: const [
                Icon(Icons.search_sharp),
                SizedBox(width: 10),
                Text('Search...')
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.settings_applications)
        ],
      ),
    );
  }
}
