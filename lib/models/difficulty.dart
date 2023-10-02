class Difficulty {
  static List<String> get difficulties {
    return List<String>.generate(_Difficulty.values.length,
        (index) => _Difficulty.values.elementAt(index).name);
  }
}

enum _Difficulty { veryEasy, easy, intermediate, hard, veryHard }
