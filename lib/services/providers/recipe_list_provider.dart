import 'package:flutter/foundation.dart';
import 'package:rezepte/services/providers/db/dbhelper.dart';

import '../../models/recipe.dart';

class RecipeListProvider extends ChangeNotifier {
  // final List<Recipe> _recipes = [];

  // set recipes(List<Recipe> recipes) {
  //   _recipes.clear();
  //   _recipes.addAll(recipes);
  //   notifyListeners();
  // }

  List<Recipe> get recipes => DbHelper.fetchRecipes(); // _recipes;

  // void clearRecipes({silent = false}) {
  //   _recipes.clear();

  //   if (!silent) notifyListeners();
  // }

  void addRecipe(Recipe recipe, {silent = false}) {
    DbHelper.putRecipe(recipe);
    if (!silent) notifyListeners();
  }
}
