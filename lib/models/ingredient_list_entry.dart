import 'ingredient.dart';
import 'unit.dart';

class IngredientListEntry {
  final Ingredient ingredient;
  final int amount;
  final Unit unit;
  final bool optional;

  IngredientListEntry(this.ingredient, this.amount, this.unit, this.optional);

  factory IngredientListEntry.fromJson(Map<String, dynamic> json) =>
      IngredientListEntry(
        Ingredient.fromJson(json['ingredient']),
        json['amount'] as int,
        Unit.fromJson(json['unit']),
        json['optional'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'ingredient': ingredient.toJson(),
        'amount': amount,
        'unit': unit.toJson(),
        'optional': optional,
      };

  @override
  operator ==(Object other) {
    final i = other as IngredientListEntry;
    return ingredient == i.ingredient;
  }

  @override
  int get hashCode {
    return Object.hash(ingredient, null);
  }
}
