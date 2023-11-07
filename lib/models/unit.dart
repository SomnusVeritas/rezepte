import 'package:isar/isar.dart';

part 'unit.g.dart';

@embedded
class Unit {
  final String name;
  final UnitType type;
  final System system;

  Unit(this.name, this.type, {this.system = System.metric});

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        json['name'] as String,
        json['type'] as UnitType,
        system: json['system'] as System,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'system': system,
      };
}

enum System { metric, imperial, neutral }

enum UnitType {
  fluid,
  weight,
  count,
}
