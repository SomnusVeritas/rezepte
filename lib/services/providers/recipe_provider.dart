import 'package:flutter/material.dart';

import '../../models/recipe.dart';

class RecipeProvider extends ChangeNotifier {
  Recipe? _recipe;

  Recipe get recipe => _recipe ??= Recipe(id: 0, title: '');

  set recipe(Recipe recipe) {
    _recipe = recipe;
    notifyListeners();
  }

  void disposeRecipe() {
    _recipe = null;
  }

  // set description(String description) {
  //   _description = description;
  //   notifyListeners();
  // }

  // String get title => _title;

  // set title(String title) {
  //   _title = title;
  //   notifyListeners();
  // }

  // Difficulty? get difficulty => _difficulty;

  // set difficulty(Difficulty? difficulty) {
  //   _difficulty = difficulty;
  //   notifyListeners();
  // }

  // List<IngredientListEntry> get ingredients => _ingredients;

  // void addIngredient(IngredientListEntry ingredient) {
  //   _ingredients.add(ingredient);
  //   notifyListeners();
  // }

  // void clearIngredients({silent = false}) {
  //   ingredients.clear();
  //   if (!silent) notifyListeners();
  // }

  // void removeIngredientAt(int index, {silent = false}) {
  //   ingredients.removeAt(index);
  //   if (!silent) notifyListeners();
  // }

  // void removeIngredient(IngredientListEntry ingredient, {silent = false}) {
  //   ingredients.removeWhere((element) => element == ingredient);
  //   if (!silent) notifyListeners();
  // }

  // List<CookingStep> get steps => _steps;

  // void addStep(CookingStep step, {silent = false}) {
  //   steps.add(step);
  //   if (!silent) notifyListeners();
  // }

  // void removeStepAt(int index, {silent = false}) {
  //   steps.removeAt(index);
  //   if (!silent) notifyListeners();
  // }
}
