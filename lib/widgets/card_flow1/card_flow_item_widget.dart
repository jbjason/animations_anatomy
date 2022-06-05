import 'package:animations_anatomy/models/card_flow.dart';
import 'package:animations_anatomy/widgets/card_flow1/bottom_flow_widget.dart';
import 'package:animations_anatomy/widgets/card_flow1/counter_flow_container.dart';
import 'package:animations_anatomy/widgets/card_flow1/top_flow_widget.dart';
import 'package:flutter/material.dart';

class CardFlowItemWidget extends StatelessWidget {
  const CardFlowItemWidget(
      {Key? key,
      required this.onSwipe,
      required this.cardItem,
      required this.selectedPage})
      : super(key: key);
  final CardFlow cardItem;
  final VoidCallback onSwipe;
  final int selectedPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (value) {
        if (value.primaryDelta! > -7) {
          onSwipe();
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: TopFlowWidget(
                cardItem: cardItem,
                padding:
                    const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
              ),
            ),
            SizedBox(
              height: 40,
              child: CounterFlowContainer(isSelected: selectedPage),
            ),
            Expanded(
                flex: 5, child: BottomFlowWidget(reviews: cardItem.reviews[0])),
          ],
        ),
      ),
    );
  }
}
