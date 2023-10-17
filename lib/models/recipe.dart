import 'difficulty.dart';
import 'ingredient.dart';
import 'cooking_step.dart';

class Recipe {
  final String title;
  final String description;
  final Difficulty? difficulty;
  final List<Ingredient> ingredients = [];
  final List<CookingStep> steps = [];

  Recipe({
    required this.title,
    this.description = '',
    this.difficulty,
  });
}
