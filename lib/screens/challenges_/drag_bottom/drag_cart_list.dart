import 'package:animations_anatomy/screens/challenges_/drag_bottom/drag_bottom_bloc.dart';
import 'package:animations_anatomy/screens/challenges_/drag_bottom/drag_cart_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DragCartList extends StatelessWidget {
  const DragCartList({Key? key, required this.state}) : super(key: key);
  final DragState state;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<DragBottomBloc>(context);
    final _books = cart.cartItems;
    final _cartDetailsItems = cart.cartDetailsItem;
    final _isNormal = state == DragState.normal;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Visibility(
            visible: state == DragState.normal,
            child: SizedBox(
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
                          (index) => Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Hero(
                                  tag:
                                      _books[index].image + _books[index].title,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage(_books[index].image),
                                    radius: 23,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    _cartDetailsItems[index].count.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
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
          ),
          // cartItem Details
          Expanded(
            child: Visibility(
              visible: !_isNormal,
              child: DragCartDetails(
                cartItem: _cartDetailsItems,
                totalAmount: cart.totalAmount(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
