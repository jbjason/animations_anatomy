import 'package:animations_anatomy/models/book.dart';
import 'package:flutter/cupertino.dart';

enum DragState { normal, cart, details }

class CartDetailsItem {
  final Book product;
  int count;

  CartDetailsItem({required this.product, this.count = 1});

  void increment() => count++;

  void decrement() {
    if (count <= 0) {
      count = 0;
    } else {
      count--;
    }
  }
}

class DragBottomBloc with ChangeNotifier {
  DragState _currentState = DragState.normal;
  final List<Book> _cartItems = [];
  final List<CartDetailsItem> _cartDetailsItem = [];

  DragState get currentState => _currentState;

  List<Book> get cartItems => [..._cartItems];
  List<CartDetailsItem> get cartDetailsItem => [..._cartDetailsItem];

  void addToCart(Book book) {
    final f = _cartItems.indexWhere((element) => book.image == element.image);
    if (f == -1) {
      _cartItems.add(book);
      _cartDetailsItem.add(CartDetailsItem(product: book));
    } else {
      _cartDetailsItem[f].count++;
    }
    notifyListeners();
  }

  double totalAmount() => cartDetailsItem.fold(
      0.0, (previousVal, element) => previousVal + element.product.price);

  void changeToCart() {
    _currentState = DragState.cart;
    notifyListeners();
  }

  void changeToNormal() {
    _currentState = DragState.normal;
    notifyListeners();
  }
}
