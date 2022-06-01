import 'package:animations_anatomy/models/card_flow.dart';
import 'package:flutter/material.dart';

class BottomFlowWidget extends StatelessWidget {
  const BottomFlowWidget({Key? key, required this.reviews}) : super(key: key);
  final CardReview reviews;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'bottom ${reviews.title}${reviews.image}',
      child: Material(
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
                  CircleAvatar(backgroundImage: AssetImage(reviews.avatar)),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(reviews.title,
                            style: const TextStyle(fontSize: 13)),
                        Text(reviews.date,
                            style: const TextStyle(fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                reviews.subtitle,
                style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                reviews.details,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
              const SizedBox(height: 6),
              Expanded(child: Image.asset(reviews.image, fit: BoxFit.cover))
            ],
          ),
        ),
      ),
    );
  }
}
