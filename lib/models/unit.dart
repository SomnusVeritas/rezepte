class Unit {
  final String name;
  final UnitType type;
  final System system;

  Unit(this.name, this.type, {this.system = System.metric});
}

enum System { metric, imperial, neutral }

enum UnitType {
  fluid,
  weight,
  count,
}
