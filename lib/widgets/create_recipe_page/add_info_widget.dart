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
  late Recipe? recipe;

  @override
  Widget build(BuildContext context) {
    recipe = Provider.of<RecipeProvider>(context, listen: true).recipe;

    if (recipe == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        TextFormField(
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          onChanged: (value) => recipe!.title = value,
          decoration: const InputDecoration(
            label: Text('Title'),
          ),
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
        TextFormField(
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          minLines: 1,
          maxLines: 4,
          onChanged: (value) => recipe!.description = value,
          decoration: const InputDecoration(
            label: Text('Description'),
          ),
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
        DropdownMenu<Difficulty>(
          dropdownMenuEntries: DifficultyUtil.getDropdownList(),
          onSelected: (value) =>
              recipe!.difficulty = value ?? Difficulty.notSelected,
          label: const Text('Difficulty'),
          textStyle:
              TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
        // ElevatedButton(
        //   onPressed: _openIngredientBottomSheet,
        //   child: const Text('Add Ingredient'),
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
