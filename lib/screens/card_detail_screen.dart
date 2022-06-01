import 'package:animations_anatomy/models/card_flow.dart';
import 'package:animations_anatomy/screens/card_flow1_screen.dart';
import 'package:animations_anatomy/widgets/card_flow1/bottom_flow_widget.dart';
import 'package:animations_anatomy/widgets/card_flow1/top_flow_widget.dart';
import 'package:flutter/material.dart';

class CardDetailScreen extends StatelessWidget {
  const CardDetailScreen({Key? key, required this.cardFlow}) : super(key: key);
  final CardFlow cardFlow;

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: TopFlowWidget(
              cardItem: cardFlow,
              padding: const EdgeInsets.only(left: 30, top: 50, bottom: 20),
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cardFlow.reviews.length,
              itemBuilder: (context, index) => Container(
                  color: Colors.transparent,
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  height: MediaQuery.of(context).size.height * .4,
                  child: BottomFlowWidget(reviews: cardFlow.reviews[index])),
            ),
          ),
        ],
      ),
    );
  }
}
