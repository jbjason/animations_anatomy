import 'package:animations_anatomy/models/ingredient.dart';
import 'package:flutter/cupertino.dart' show ChangeNotifier;

class PizzaBloc with ChangeNotifier {
  int total = 15;
  final List<Ingredient> listIngredients = [];

  void setInitialList() {
    listIngredients.clear();
    total = 15;
  }

  void addIngredient(Ingredient ingredient) {
    listIngredients.add(ingredient);
    total++;
    notifyListeners();
  }

  void removeIngredient(Ingredient ingredient) {
    listIngredients.remove(ingredient);
    total--;
    notifyListeners();
  }

  bool containsIngredient(Ingredient ingredient) {
    // this loop works for onWillAccept*(dragTargetion)
    // reverse condition for PizzaIngredientsScreen
    for (Ingredient i in listIngredients) {
      if (i.image == ingredient.image) {
        return false;
      }
    }
    return true;
  }
}
