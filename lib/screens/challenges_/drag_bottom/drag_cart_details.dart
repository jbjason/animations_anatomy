import 'package:animations_anatomy/screens/challenges_/drag_bottom/drag_bottom_bloc.dart';
import 'package:flutter/material.dart';

class DragCartDetails extends StatelessWidget {
  const DragCartDetails(
      {Key? key, required this.cartItem, required this.totalAmount})
      : super(key: key);
  final List<CartDetailsItem> cartItem;
  final double totalAmount;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(
            "Cart",
            style: Theme.of(context)
                .textTheme
                .headline2
                ?.copyWith(color: Colors.white),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: cartItem.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(cartItem[index].product.image),
                ),
                title: Row(children: [
                  Text(
                    "${cartItem[index].count} x  ",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    cartItem[index].product.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: Colors.white),
                  ),
                ]),
                trailing: FittedBox(
                  child: Row(
                    children: [
                      Text(
                        '\$ ${cartItem[index].product.price}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const Text(
                'Total:',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                totalAmount.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(15),
          // ignore: deprecated_member_use
          child: RaisedButton(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'Next',
                style: TextStyle(letterSpacing: 1, wordSpacing: 2),
              ),
            ),
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
