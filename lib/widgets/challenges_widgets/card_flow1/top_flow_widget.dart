import 'package:animations_anatomy/models/card_flow.dart';
import 'package:flutter/material.dart';

class TopFlowWidget extends StatelessWidget {
  const TopFlowWidget({Key? key, required this.cardItem, required this.padding})
      : super(key: key);
  final CardFlow cardItem;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final _title = TextStyle(
        color:
            Colors.black.computeLuminance() < .5 ? Colors.white : Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.bold);
    final _place = TextStyle(
        fontSize: 13,
        color:
            Colors.black.computeLuminance() < .5 ? Colors.white : Colors.black);
    const _checkIn = TextStyle(
        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black);
    return Hero(
      tag: 'top ${cardItem.title}',
      child: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(cardItem.image, fit: BoxFit.cover)),
          Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(cardItem.title, style: _title),
                Text(cardItem.price, style: _title),
                const SizedBox(height: 20),
                Text(cardItem.place, style: _place),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cardItem.date, style: _place),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.4)),
                        child: const Text('CheckIn', style: _checkIn),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
