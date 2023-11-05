import 'unit.dart';

class Ingredient {
  final String title;
  List<Unit> possibleUnits;
  List<String> preferredBrands;

  Ingredient({
    required this.title,
    this.possibleUnits = const [],
    this.preferredBrands = const [],
  });

  @override
  bool operator ==(other) {
    Ingredient i = other as Ingredient;
    return title == i.title;
  }

  @override
  int get hashCode {
    return Object.hash(title, null);
  }
}
