import 'package:flutter/material.dart';
import '../../models/difficulty.dart';
import '../../models/cooking_step.dart';
import '../../models/ingredient_list_entry.dart';

import '../../models/recipe.dart';

class RecipeProvider extends ChangeNotifier implements Recipe {
  String _title = '';
  String _description = '';
  Difficulty? _difficulty;
  final List<IngredientListEntry> _ingredients = [];
  final List<CookingStep> _steps = [];

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

  @override
  String get description => _description;

  set description(String description) {
    _description = description;
    notifyListeners();
  }

  @override
  String get title => _title;

  set title(String title) {
    _title = title;
    notifyListeners();
  }

  @override
  Difficulty? get difficulty => _difficulty;

  set difficulty(Difficulty? difficulty) {
    _difficulty = difficulty;
    notifyListeners();
  }

  @override
  List<IngredientListEntry> get ingredients => _ingredients;

  @override
  void addIngredient(IngredientListEntry ingredient) {
    _ingredients.add(ingredient);
    notifyListeners();
  }

  @override
  void clearIngredients({silent = false}) {
    ingredients.clear();
    if (!silent) notifyListeners();
  }

  @override
  void removeIngredientAt(int index, {silent = false}) {
    ingredients.removeAt(index);
    if (!silent) notifyListeners();
  }

  @override
  void removeIngredient(IngredientListEntry ingredient, {silent = false}) {
    ingredients.removeWhere((element) => element == ingredient);
    if (!silent) notifyListeners();
  }

  @override
  List<CookingStep> get steps => _steps;

  @override
  void addStep(CookingStep step, {silent = false}) {
    steps.add(step);
    if (!silent) notifyListeners();
  }

  @override
  void removeStepAt(int index, {silent = false}) {
    steps.removeAt(index);
    if (!silent) notifyListeners();
  }
}
