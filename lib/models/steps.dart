/// Used to display the steps required to cook the referenced recipe
class Steps {
  final List<CookingStep> steps = [];

  void add(CookingStep step) => steps.add(step);
}

class CookingStep {
  final String title;
  final String description;

  CookingStep({required this.title, this.description = ''});
}
