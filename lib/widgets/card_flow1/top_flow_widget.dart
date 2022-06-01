import 'package:animations_anatomy/models/card_flow.dart';
import 'package:flutter/material.dart';

class TopFlowWidget extends StatelessWidget {
  const TopFlowWidget({Key? key, required this.cardItem, required this.padding})
      : super(key: key);
  final CardFlow cardItem;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Hero(
      tag: 'top ${cardItem.title}',
      child: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(cardItem.image, fit: BoxFit.cover)),
          Container(
            padding: padding,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardItem.title,
                  style: TextStyle(
                      color: Colors.black.computeLuminance() < .5
                          ? Colors.white
                          : Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  cardItem.price,
                  style: TextStyle(
                      color: Colors.black.computeLuminance() < .5
                          ? Colors.white
                          : Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  cardItem.place,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.computeLuminance() < .5
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                Text(
                  cardItem.date,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black.computeLuminance() < .5
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.4)),
                  child: const Text('CheckIn', overflow: TextOverflow.ellipsis),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
