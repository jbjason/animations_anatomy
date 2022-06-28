import 'package:animations_anatomy/models/book.dart';
import 'package:flutter/material.dart';

class BankAppItem extends StatelessWidget {
  const BankAppItem(
      {Key? key,
      required this.book,
      required this.percent,
      required this.index})
      : super(key: key);
  final Book book;
  final int index;
  final double percent;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return index == 0
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: size.height * .55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        image: AssetImage(book.image), fit: BoxFit.cover),
                  ),
                  child: const Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      '\$ 10346 ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                ),
                Opacity(
                  opacity: 1 - percent,
                  child: Transform.translate(
                    offset: Offset(0, 50 * percent),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage('assets/card_/jb1.jpg'),
                          ),
                          Expanded(
                            child: Text(
                              book.author,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                          const Text(
                            '+36.00',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
