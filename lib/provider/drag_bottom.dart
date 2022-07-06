import 'package:animations_anatomy/models/book.dart';
import 'package:flutter/cupertino.dart';

enum DragState { normal, cart, details }

class DragBottom with ChangeNotifier {
  DragState _currentState = DragState.normal;
  final List<Book> _cartItems = [];

  DragState get currentState {
    return _currentState;
  }

  List<Book> get cartItems {
    return [..._cartItems];
  }

  void addToCart(Book book) {
    _cartItems.add(book);
    notifyListeners();
  }

  void changeToCart() {
    _currentState = DragState.cart;
    notifyListeners();
  }

  void changeToNormal() {
    _currentState = DragState.normal;
    notifyListeners();
  }
}
