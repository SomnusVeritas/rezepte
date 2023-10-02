import 'ingredient.dart';
import 'steps.dart';

class Recipe {
  final String title;
  final String description;
  final Difficulty? difficulty;
  final List<Ingredient> ingredients = [];
  final Steps steps = Steps();

  Recipe({
    required this.title,
    this.description = '',
    this.difficulty,
  });
}

enum Difficulty { veryEasy, easy, intermediate, hard, veryHard }
