import 'unit.dart';

class Ingredient {
  final String title;
  List<Unit> possibleUnits = [];
  List<String> preferredBrands = [];

  Ingredient({
    required this.title,
    required this.possibleUnits,
    required this.preferredBrands,
  });
}
