import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import '../../../models/recipe.dart';

class DbHelper {
  static late Directory _dir;
  static Isar get _isar => Isar.open(
        schemas: _schemas,
        directory: _dir.path,
      );

  static const List<IsarGeneratedSchema> _schemas = [
    RecipeSchema,
  ];
  static int get nextRecipeId => _isar.recipes.autoIncrement();

  static Future<void> init() async {
    _dir = await getApplicationDocumentsDirectory();
  }

  static List<Recipe> fetchRecipes() {
    return _isar.recipes.where().findAll().cast<Recipe>().toList();
  }

  static void putRecipe(Recipe recipe) {
    _isar.write((isar) => isar.recipes.put(recipe));
  }

  static bool deleteRecipe(Recipe recipe) {
    return _isar.write((isar) => isar.recipes.delete(recipe.id));
  }

  static Stream<void> get recipesChangedStream => _isar.recipes.watchLazy();
}
