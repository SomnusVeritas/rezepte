import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/difficulty.dart';
import '../../models/recipe.dart';
import '../../services/providers/recipe_provider.dart';

class AddRecipeInfoWidget extends StatefulWidget {
  const AddRecipeInfoWidget({super.key});

  @override
  State<AddRecipeInfoWidget> createState() => _AddRecipeInfoWidgetState();
}

class _AddRecipeInfoWidgetState extends State<AddRecipeInfoWidget> {
  late RecipeProvider recipeProvider;

  @override
  Widget build(BuildContext context) {
    recipeProvider = Provider.of<RecipeProvider>(context, listen: true);

    if (recipeProvider.recipe == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        TextFormField(
          initialValue: recipeProvider.recipe!.title,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          onChanged: (value) => recipeProvider.recipe!.title = value,
          decoration: const InputDecoration(
            label: Text('Title'),
          ),
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
        TextFormField(
          initialValue: recipeProvider.recipe!.description,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          minLines: 1,
          maxLines: 4,
          onChanged: (value) => recipeProvider.recipe!.description = value,
          decoration: const InputDecoration(
            label: Text('Description'),
          ),
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
        DropdownMenu<Difficulty>(
          initialSelection: recipeProvider.recipe!.difficulty,
          dropdownMenuEntries: DifficultyUtil.getDropdownList(),
          onSelected: (value) => recipeProvider.recipe!.difficulty =
              value ?? Difficulty.notSelected,
          label: const Text('Difficulty'),
          textStyle:
              TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
        // ElevatedButton(
        //   onPressed: _openIngredientBottomSheet,
        //   child: const Text('Add Ingred  ient'),
        // ),
        // Expanded(
        //   child: ListView.separated(
        //     itemCount: recipe.ingredients.length,
        //     itemBuilder: _ingredientListBuilder,
        //     separatorBuilder: (context, index) => const Divider(),
        //   ),
        // )
      ],
    );
  }
}
