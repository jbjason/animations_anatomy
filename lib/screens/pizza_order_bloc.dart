import 'package:animations_anatomy/models/ingredient.dart';
import 'package:flutter/cupertino.dart' show ChangeNotifier;

class PizzaOrderBloc with ChangeNotifier {
  int total = 15;
  final List<Ingredient> listIngredients = [];

  void addIngredient(Ingredient ingredient) {
    listIngredients.add(ingredient);
    total++;
    notifyListeners();
  }

  bool containsIngredient(Ingredient ingredient) {
    for (Ingredient i in listIngredients) {
      if (i.image == ingredient.image) {
        return false;
      }
    }
    return true;
  }
}
