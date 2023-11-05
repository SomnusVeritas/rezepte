import 'difficulty.dart';
import 'cooking_step.dart';
import 'ingredient_list_entry.dart';

class Recipe {
  String title;
  String description;
  Difficulty? difficulty;
  final List<IngredientListEntry> ingredients = [];
  final List<CookingStep> steps = [];

  Recipe({
    required this.title,
    this.description = '',
    this.difficulty,
  });

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
}
