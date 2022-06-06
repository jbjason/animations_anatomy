import 'package:animations_anatomy/models/sync_tabbar.dart';
import 'package:animations_anatomy/widgets/tapbar_widgets/sync_concept_.dart';
import 'package:flutter/material.dart';

class SyncProductItem extends StatelessWidget {
  const SyncProductItem({Key? key, required this.product}) : super(key: key);
  final SyncProduct product;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: productHeight,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Image.asset(product.image, fit: BoxFit.cover, width: 150),
            const SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                      color: Colors.blueGrey[900],
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(product.details,
                    maxLines: 2, style: const TextStyle(fontSize: 11)),
                Text(
                  '\$ ${product.price}',
                  style: const TextStyle(
                      color: Colors.tealAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
