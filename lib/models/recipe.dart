import 'difficulty.dart';
import 'cooking_step.dart';
import 'ingredient_list_entry.dart';

class Recipe {
  String title;
  String description;
  Difficulty? difficulty;
  List<IngredientListEntry> ingredients = [];
  List<CookingStep> steps = [];

  Recipe({
    required this.title,
    this.description = '',
    this.difficulty,
  });

  factory Recipe.fromJson(json) => Recipe(
        title: json['title'] as String,
        description: json['description'] as String,
        // difficulty: json['difficulty'] as Difficulty?,
      );
  // ..ingredients = _ingredientsFromMap(
  //     json['ingredients'] as List<Map<String, dynamic>>)
  // ..steps = _stepsFromMap(json['steps']);

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        // 'difficulty': difficulty,
        // 'ingredients': ingredients.map((e) => e.toJson()).toList(),
        // 'steps': steps.map((e) => e.toJson()).toList(),
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
        difficulty == null &&
        ingredients.isEmpty &&
        steps.isEmpty;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }

  void clear() {
    title = '';
    description = '';
    difficulty = null;
    ingredients.clear();
    steps.clear();
  }

  static List<IngredientListEntry> _ingredientsFromMap(
          List<Map<String, dynamic>> jsonList) =>
      jsonList.map((e) => IngredientListEntry.fromJson(e)).toList();

  static List<CookingStep> _stepsFromMap(List<Map<String, dynamic>> jsonList) =>
      jsonList.map((e) => CookingStep.fromJson(e)).toList();
}
