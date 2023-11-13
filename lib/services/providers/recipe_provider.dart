import 'package:flutter/material.dart';

import '../../models/recipe.dart';

class RecipeProvider extends ChangeNotifier {
  Recipe? _recipe;

  Recipe? get recipe => _recipe;

  set recipe(Recipe? recipe) {
    _recipe = recipe;
    notifyListeners();
  }

  void disposeRecipe() {
    _recipe = null;
  }
}
