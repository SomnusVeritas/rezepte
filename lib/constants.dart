import 'models/unit.dart';

Iterable<Unit> units = [
  Unit('mg', UnitType.weight),
  Unit('g', UnitType.weight),
  Unit('kg', UnitType.weight),
  Unit('ml', UnitType.fluid),
  Unit('cl', UnitType.fluid),
  Unit('dl', UnitType.fluid),
  Unit('l', UnitType.fluid),
  Unit('teaspoon', UnitType.fluid, system: System.imperial),
  Unit('tablespoon', UnitType.fluid, system: System.imperial),
  Unit('cup', UnitType.fluid, system: System.imperial),
  Unit('pint', UnitType.fluid, system: System.imperial),
  Unit('pieces', UnitType.count, system: System.neutral),
];
