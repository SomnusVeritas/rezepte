import 'package:isar/isar.dart';

import 'unit.dart';

part 'ingredient.g.dart';

@embedded
class Ingredient {
  final String title;
  List<Unit> possibleUnits;
  List<String> preferredBrands;

  Ingredient({
    required this.title,
    this.possibleUnits = const [],
    this.preferredBrands = const [],
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        title: json['title'] as String,
        possibleUnits: _unitsFromJson(json['possibleUnits']),
        preferredBrands: json['preferredBrands'] as List<String>,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'possibleUnits': possibleUnits.map((e) => e.toJson()).toList(),
        'preferredBrands': preferredBrands,
      };

  @override
  bool operator ==(other) {
    Ingredient i = other as Ingredient;
    return title == i.title;
  }

  @override
  int get hashCode {
    return Object.hash(title, null);
  }

  static List<Unit> _unitsFromJson(List<Map<String, dynamic>> jsonList) =>
      jsonList.map((e) => Unit.fromJson(e)).toList();
}
