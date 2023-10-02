class Ingredient {
  final String title;
  List<String> possibleUnits = [];
  List<String> preferredBrands = [];

  Ingredient({
    required this.title,
    required this.possibleUnits,
    required this.preferredBrands,
  });
}
