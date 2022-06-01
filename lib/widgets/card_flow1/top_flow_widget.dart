import 'package:animations_anatomy/models/card_flow.dart';
import 'package:flutter/material.dart';

class TopFlowWidget extends StatelessWidget {
  const TopFlowWidget({Key? key, required this.cardItem, required this.padding})
      : super(key: key);
  final CardFlow cardItem;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
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
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cardItem.date,
                        style:
                            const TextStyle(fontSize: 11, color: Colors.white),
                      ),
                      // Container(
                      //   padding: const EdgeInsets.all(10),
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(20),
                      //       color: Colors.white.withOpacity(0.2)),
                      //   child: const Text('CheckIn',
                      //       overflow: TextOverflow.ellipsis),
                      // )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
