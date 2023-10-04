import 'package:rezepte/models/unit.dart';

import 'models/ingredient.dart';
import 'constants.dart' as constants;

final List<Unit> _weightAndCount = constants.units
    .where((element) =>
        element.type == UnitType.weight || element.type == UnitType.count)
    .toList();

final List<Unit> _weight = constants.units
    .where((element) => element.type == UnitType.weight)
    .toList();

final List<Unit> _count =
    constants.units.where((element) => element.type == UnitType.count).toList();

final List<Unit> _fluid =
    constants.units.where((element) => element.type == UnitType.fluid).toList();

final List<Ingredient> exampleIngredients = [
  Ingredient(title: 'Karotte', possibleUnits: _weightAndCount),
  Ingredient(title: 'Kartoffel', possibleUnits: _weightAndCount),
  Ingredient(title: 'Kaffeebohnen', possibleUnits: _weight),
  Ingredient(title: 'Milch', possibleUnits: _fluid),
  Ingredient(title: 'Limettenblätter', possibleUnits: _count),
];
