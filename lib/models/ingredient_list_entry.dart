import 'ingredient.dart';
import 'unit.dart';

class IngredientListEntry {
  final Ingredient ingredient;
  final int amount;
  final Unit unit;
  final bool optional;

  IngredientListEntry(this.ingredient, this.amount, this.unit, this.optional);
}
