import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../models/recipe.dart';
import '../../../example_data.dart' as e;

class DbHelper {
  static Box<Recipe> get _recipesBox => Hive.box(name: 'recipes');

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.defaultDirectory = dir.path;
    Hive.registerAdapter('Recipe', Recipe.fromJson);
    _recipesBox.clear();
    for (final recipe in e.exampleRecipes) {
      insertRecipe(recipe);
    }
  }

  static List<Recipe> fetchRecipes() {
    List<Recipe> recipes = _recipesBox.getAll(['0', '1']).cast<Recipe>();

    return recipes;
  }

  static void insertRecipe(Recipe recipe) {
    _recipesBox.put(_recipesBox.length.toString(), recipe);
  }
}
