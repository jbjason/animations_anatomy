import 'package:animations_anatomy/models/sync_tabbar.dart';
import 'package:animations_anatomy/widgets/challenges_widgets/sync_widgets/sync_concept_.dart';
import 'package:flutter/material.dart';

class SyncProductItem extends StatelessWidget {
  const SyncProductItem({Key? key, required this.product}) : super(key: key);
  final SyncProduct product;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      margin: const EdgeInsets.only(left: 5),
      height: productHeight,
      child: Material(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Container(
              width: 150,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(product.image), fit: BoxFit.cover)),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(
                        color: Colors.blueGrey[800],
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(product.details,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 11)),
                  Text(
                    '\$ ${product.price}',
                    style: TextStyle(
                        color: Colors.teal[900],
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
