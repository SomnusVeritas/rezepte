import 'package:flutter/foundation.dart';
import 'package:rezepte/services/providers/db/dbhelper.dart';

import '../../models/recipe.dart';
import 'package:rezepte/example_data.dart' as e;

class RecipeListProvider extends ChangeNotifier {
  final List<Recipe> _recipes = kDebugMode ? e.exampleRecipes : [];

  set recipes(List<Recipe> recipes) {
    _recipes.clear();
    _recipes.addAll(recipes);
    notifyListeners();
  }

  List<Recipe> get recipes => DbHelper.fetchRecipes();

  void clearRecipes({silent = false}) {
    _recipes.clear();

    if (!silent) notifyListeners();
  }

  void addRecipe(Recipe recipe, {silent = false}) {
    _recipes.add(recipe);
    if (!silent) notifyListeners();
  }
}
