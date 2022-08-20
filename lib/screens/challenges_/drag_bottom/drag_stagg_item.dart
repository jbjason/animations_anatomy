import 'package:animations_anatomy/models/book.dart';
import 'package:animations_anatomy/screens/challenges_/drag_bottom/drag_bottom_details.dart';
import 'package:flutter/material.dart';

class DragStaggItem extends StatelessWidget {
  const DragStaggItem(
      {Key? key,
      required this.book,
      required this.index,
      required this.itemHeight})
      : super(key: key);
  final Book book;
  final int index;
  final double itemHeight;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => DragBottomDetails(book: book))),
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..translate(0.0, index.isOdd ? itemHeight * .5 : 0.0),
        child: Card(
          elevation: 10,
          shadowColor: Colors.black87,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                      tag: book.image,
                      child: Image.asset(book.image, fit: BoxFit.fitWidth)),
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '\$ 18.45',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    book.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 14),
                  ),
                  Text(
                    book.author,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
