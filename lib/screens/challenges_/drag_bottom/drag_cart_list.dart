import 'package:animations_anatomy/provider/drag_bottom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DragCartList extends StatelessWidget {
  const DragCartList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _books = Provider.of<DragBottomBloc>(context).cartItems;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 80,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Cart : ',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      _books.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Hero(
                          tag: _books[index].image + _books[index].title,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(_books[index].image),
                            radius: 23,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 26,
                backgroundColor: const Color.fromARGB(255, 211, 164, 94),
                child: Text(
                  _books.length.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
