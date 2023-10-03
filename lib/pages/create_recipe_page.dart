import 'package:flutter/material.dart';
import 'package:rezepte/widgets/dropdown_textfield.dart';
import 'package:rezepte/widgets/ingredients_list.dart';

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
                hintText: 'Title',
              ),
            ),
            TextFormField(
              controller: descriptionText,
              decoration: const InputDecoration(
                hintText: 'Description',
              ),
            ),
            const DifficultyDropdown(),
            const IngredientsList(),
            const DropdownTextfield(),
          ],
        ),
      ),
    );
  }
}
