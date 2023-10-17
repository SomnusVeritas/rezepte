class DifficultyUtil {
  /// Converts lowerCamelCase or UpperCamelCase enum-names to 'normal' Strings
  static String getName(Difficulty difficulty) {
    String name = difficulty.name
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => ' ${match[0]}');
    name = name[0].toUpperCase() + name.substring(1);
    return name;
  }
}

// Only use camelCase or UpperCamelCase for names
enum Difficulty { veryEasy, easy, intermediate, hard, veryHard }
