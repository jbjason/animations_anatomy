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
      child: AnimatedContainer(
        width: 110,
        duration: const Duration(milliseconds: 500),
        child: Row(
          children: List.generate(
            length,
            (index) => Container(
              height: 20,
              width: 20,
              padding: isSelected == index
                  ? const EdgeInsets.all(5)
                  : const EdgeInsets.all(0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected == index ? Colors.white : Colors.grey,
                border: Border.all(
                    width: 2,
                    color: isSelected == index
                        ? Colors.white.withOpacity(0.2)
                        : Colors.transparent),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
