import 'package:flutter/material.dart';
import 'package:rezepte/models/difficulty.dart';
import 'package:rezepte/models/ingredient.dart';
import 'package:rezepte/models/steps.dart';

import '../../models/recipe.dart';

class RecipeProvider extends ChangeNotifier implements Recipe {
  String _title = '';
  String _description = '';
  Difficulty? _difficulty;
  List<Ingredient> _ingredients = [];
  Steps _steps = Steps();

  void clearRecipe() {
    _title = '';
    _description = '';
    _difficulty = null;
    _ingredients = [];
    _steps = Steps();
    notifyListeners();
  }

  @override
  String get description => _description;

  @override
  String get title => _title;

  @override
  Difficulty? get difficulty => _difficulty;

  @override
  List<Ingredient> get ingredients => _ingredients;

  @override
  Steps get steps => _steps;
}
