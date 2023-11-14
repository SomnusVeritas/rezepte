import 'package:isar/isar.dart';

part 'cooking_step.g.dart';

@embedded
class CookingStep {
  final String title;
  final String description;

  CookingStep({required this.title, this.description = ''});

  factory CookingStep.fromJson(Map<String, dynamic> json) => CookingStep(
        title: json['title'] as String,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
      };
}
