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
    final _price = TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color:
            Colors.black.computeLuminance() < .5 ? Colors.white : Colors.black);
    final _place = TextStyle(
        fontSize: 13,
        color:
            Colors.black.computeLuminance() < .5 ? Colors.white : Colors.black);
    final _date = TextStyle(
        fontSize: 11,
        color:
            Colors.black.computeLuminance() < .5 ? Colors.white : Colors.black);
    return Hero(
      tag: 'top ${cardItem.title}',
      child: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(cardItem.image, fit: BoxFit.cover)),
          Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cardItem.title, style: _title),
                Text(cardItem.price, style: _price),
                const SizedBox(height: 20),
                Text(cardItem.place, style: _place),
                Row(
                  children: [
                    Text(cardItem.date, style: _date),
                    const Spacer(),
                    // Container(
                    //   padding: const EdgeInsets.all(10),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(20),
                    //       color: Colors.white.withOpacity(0.4)),
                    //   child: const Text('CheckIn',
                    //       overflow: TextOverflow.ellipsis),
                    // ),
                    // const SizedBox(width: 10),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
