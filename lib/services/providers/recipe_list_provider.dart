import 'package:flutter/material.dart';

import '../../models/recipe.dart';

class RecipeListProvider extends ChangeNotifier {
  final List<Recipe> _recipes = [];

  set recipes(List<Recipe> recipes) {
    _recipes.clear();
    _recipes.addAll(recipes);
    notifyListeners();
  }

  List<Recipe> get recipes => _recipes;

  void clearRecipes({silent = false}) {
    _recipes.clear();

    if (!silent) notifyListeners();
  }

  void addRecipe(Recipe recipe, {silent = false}) {
    _recipes.add(recipe);
    if (!silent) notifyListeners();
  }
}
