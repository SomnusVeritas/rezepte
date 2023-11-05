import 'difficulty.dart';
import 'cooking_step.dart';
import 'ingredient_list_entry.dart';

class Recipe {
  final String title;
  final String description;
  final Difficulty? difficulty;
  final List<IngredientListEntry> ingredients;
  final List<CookingStep> steps;

  Recipe({
    required this.title,
    this.description = '',
    this.difficulty,
    this.ingredients = const [],
    this.steps = const [],
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
}
