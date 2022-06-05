import 'package:animations_anatomy/models/card_flow.dart';
import 'package:flutter/material.dart';

class CounterFlowContainer extends StatelessWidget {
  const CounterFlowContainer({Key? key, required this.isSelected})
      : super(key: key);
  final int isSelected;
  @override
  Widget build(BuildContext context) {
    final length = cardFlows.length;
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            length,
            (index) => Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: isSelected == index
                        ? Colors.white.withOpacity(0.4)
                        : Colors.transparent),
              ),
              child: Container(
                height: 10,
                width: 10,
                padding: const EdgeInsets.all(3),
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.2),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
