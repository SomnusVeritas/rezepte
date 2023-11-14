import 'package:isar/isar.dart';
import 'package:rezepte/models/ingredient.dart';
import 'package:rezepte/models/unit.dart';

import 'difficulty.dart';
import 'cooking_step.dart';
import 'ingredient_list_entry.dart';

part 'recipe.g.dart';

@collection
class Recipe {
  final int id;
  String title;
  String description;
  Difficulty difficulty;
  List<IngredientListEntry> ingredients = [];
  List<CookingStep> steps = [];

  Recipe({
    required this.id,
    required this.title,
    this.description = '',
    this.difficulty = Difficulty.notSelected,
  });

  factory Recipe.fromJson(json) => Recipe(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        difficulty: json['difficulty'] as Difficulty,
      )
        ..ingredients = _ingredientsFromMap(
            json['ingredients'] as List<Map<String, dynamic>>)
        ..steps = _stepsFromMap(json['steps']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'difficulty': difficulty,
        'ingredients': ingredients.map((e) => e.toJson()).toList(),
        'steps': steps.map((e) => e.toJson()).toList(),
      };

  void addIngredient(IngredientListEntry ingredient) =>
      ingredients.add(ingredient);

  void clearIngredients() => ingredients.clear();

  void removeIngredientAt(int index) {
    ingredients.removeAt(index);
  }

  void removeIngredient(IngredientListEntry ingredient) {
    ingredients.removeWhere((element) => element == ingredient);
  }

  void addStep(CookingStep step) => steps.add(step);

  void removeStepAt(int index) => steps.removeAt(index);

  bool get isEmpty {
    return title.isEmpty &&
        description.isEmpty &&
        difficulty == Difficulty.notSelected &&
        ingredients.isEmpty &&
        steps.isEmpty;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }

  void clear() {
    title = '';
    description = '';
    difficulty = Difficulty.notSelected;
    ingredients.clear();
    steps.clear();
  }

  static List<IngredientListEntry> _ingredientsFromMap(
          List<Map<String, dynamic>> jsonList) =>
      jsonList.map((e) => IngredientListEntry.fromJson(e)).toList();

  static List<CookingStep> _stepsFromMap(List<Map<String, dynamic>> jsonList) =>
      jsonList.map((e) => CookingStep.fromJson(e)).toList();
}
