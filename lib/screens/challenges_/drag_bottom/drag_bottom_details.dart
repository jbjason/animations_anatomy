import 'package:animations_anatomy/models/book.dart';
import 'package:animations_anatomy/screens/challenges_/drag_bottom/drag_bottom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DragBottomDetails extends StatefulWidget {
  const DragBottomDetails({Key? key, required this.book}) : super(key: key);
  final Book book;
  @override
  State<DragBottomDetails> createState() => _DragBottomDetailsState();
}

class _DragBottomDetailsState extends State<DragBottomDetails> {
  String _tag = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: kToolbarHeight,
              child: AppBar(
                centerTitle: true,
                title: const Text('Item Details'),
                backgroundColor: Colors.grey[900],
                leading: IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.arrow_back_ios_new)),
              ),
            ),
            SizedBox(
              height: 500,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(20)),
                child: Hero(
                    tag: widget.book.image + _tag,
                    child: Image.asset(widget.book.image, fit: BoxFit.cover)),
              ),
            ),
            const SizedBox(height: 100),
            Text(widget.book.title,
                style: TextStyle(
                    color: Colors.grey[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            Text(widget.book.author,
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() => _tag = widget.book.title);
                Provider.of<DragBottomBloc>(context, listen: false)
                    .addToCart(widget.book);
                Navigator.pop(context);
              },
              child: const Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
