import 'package:flutter/material.dart';
import '../widgets/ingredients_widget.dart';

import '../models/difficulty.dart';
import '../widgets/difficulty_dropdown.dart';

class CreateRecipe extends StatefulWidget {
  const CreateRecipe({super.key});
  static const routeName = '/createRecipe';

  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  Difficulty? _recipeDifficulty;

  TextEditingController titleText = TextEditingController();
  TextEditingController descriptionText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Recipe'),
      ),
      body: Form(
        child: Column(
          children: [
            TextFormField(
              controller: titleText,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
            TextFormField(
              controller: descriptionText,
              decoration: const InputDecoration(
                label: Text('Description'),
              ),
            ),
            const DifficultyDropdown(),
            IngredientsWidget(
              width: width * 0.9,
            ),
          ],
        ),
      ),
    );
  }
}
