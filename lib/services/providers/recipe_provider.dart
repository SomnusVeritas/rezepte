import 'package:flutter/material.dart';

import '../../models/recipe.dart';

class RecipeProvider extends ChangeNotifier {
  Recipe? _selectedRecipe;

  Recipe? get selectedRecipe => _selectedRecipe;

  set selectedRecipe(Recipe? recipe) {
    _selectedRecipe = recipe;
    notifyListeners();
  }

  void clearRecipe() {
    _selectedRecipe = null;
    notifyListeners();
  }
}
