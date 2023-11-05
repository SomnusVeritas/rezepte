import 'package:flutter/material.dart';
import '../../models/difficulty.dart';
import '../../models/cooking_step.dart';
import '../../models/ingredient_list_entry.dart';

import '../../models/recipe.dart';

class RecipeProvider extends ChangeNotifier {
  String _title = '';
  String _description = '';
  Difficulty? _difficulty;
  final List<IngredientListEntry> _ingredients = [];
  final List<CookingStep> _steps = [];

  Recipe get recipe => Recipe(
      title: _title,
      description: _description,
      difficulty: _difficulty,
      ingredients: _ingredients,
      steps: _steps);

  void clearRecipe({silent = false}) {
    _title = '';
    _description = '';
    _difficulty = null;
    _ingredients.clear();
    _steps.clear();
    if (!silent) {
      notifyListeners();
    }
  }

  bool get isEmpty {
    return _title.isEmpty &&
        _description.isEmpty &&
        _difficulty == null &&
        _ingredients.isEmpty &&
        steps.isEmpty;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }

  String get description => _description;

  set description(String description) {
    _description = description;
    notifyListeners();
  }

  String get title => _title;

  set title(String title) {
    _title = title;
    notifyListeners();
  }

  Difficulty? get difficulty => _difficulty;

  set difficulty(Difficulty? difficulty) {
    _difficulty = difficulty;
    notifyListeners();
  }

  List<IngredientListEntry> get ingredients => _ingredients;

  void addIngredient(IngredientListEntry ingredient) {
    _ingredients.add(ingredient);
    notifyListeners();
  }

  void clearIngredients({silent = false}) {
    ingredients.clear();
    if (!silent) notifyListeners();
  }

  void removeIngredientAt(int index, {silent = false}) {
    ingredients.removeAt(index);
    if (!silent) notifyListeners();
  }

  void removeIngredient(IngredientListEntry ingredient, {silent = false}) {
    ingredients.removeWhere((element) => element == ingredient);
    if (!silent) notifyListeners();
  }

  List<CookingStep> get steps => _steps;

  void addStep(CookingStep step, {silent = false}) {
    steps.add(step);
    if (!silent) notifyListeners();
  }

  void removeStepAt(int index, {silent = false}) {
    steps.removeAt(index);
    if (!silent) notifyListeners();
  }
}
