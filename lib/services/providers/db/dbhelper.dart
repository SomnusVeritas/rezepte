import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import '../../../models/recipe.dart';
import '../../../example_data.dart' as e;

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

    if (kDebugMode) {
      _isar.write((isar) => _isar.recipes.putAll(e.exampleRecipes));
    }
  }

  static List<Recipe> fetchRecipes() {
    return _isar.recipes
        .getAll([1, 2])
        .where((element) => element != null)
        .cast<Recipe>()
        .toList();
  }
}
