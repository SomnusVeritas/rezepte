class DifficultyUtil {
  static List<String> get difficulties {
    return List<String>.generate(Difficulty.values.length,
        (index) => Difficulty.values.elementAt(index).name);
  }
}

enum Difficulty { veryEasy, easy, intermediate, hard, veryHard }
