import 'difficulty.dart';
import 'cooking_step.dart';
import 'ingredient_list_entry.dart';

class Recipe {
  final String title;
  final String description;
  final Difficulty? difficulty;
  final List<IngredientListEntry> ingredients = [];
  final List<CookingStep> steps = [];

  Recipe({
    required this.title,
    this.description = '',
    this.difficulty,
  });
}
