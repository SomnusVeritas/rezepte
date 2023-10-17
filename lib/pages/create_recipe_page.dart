import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rezepte/widgets/ingredients_bottomsheet.dart';
import '../models/difficulty.dart';
import '../services/providers/recipe_provider.dart';

class CreateRecipe extends StatefulWidget {
  const CreateRecipe({super.key});
  static const routeName = '/createRecipe';

  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  late RecipeProvider recipeProvider;

  @override
  Widget build(BuildContext context) {
    recipeProvider = Provider.of<RecipeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Recipe'),
      ),
      body: Form(
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) => recipeProvider.title = value,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
            TextFormField(
              onChanged: (value) => recipeProvider.description = value,
              decoration: const InputDecoration(
                label: Text('Description'),
              ),
            ),
            DropdownMenu<Difficulty?>(
              dropdownMenuEntries: DifficultyUtil.getDropdownList(),
              onSelected: (value) => recipeProvider.difficulty = value,
            ),
            ElevatedButton(
              onPressed: _openIngredientBottomSheet,
              child: const Text('Add Ingredient'),
            ),
          ],
        ),
      ),
    );
  }

  void _openIngredientBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const IngredientsBottomsheet(),
    );
  }
}
