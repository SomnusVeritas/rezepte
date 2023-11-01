import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rezepte/widgets/ingredients_bottomsheet.dart';
import '../models/difficulty.dart';
import '../models/ingredient_list_entry.dart';
import '../services/providers/recipe_provider.dart';

class CreateRecipe extends StatefulWidget {
  const CreateRecipe({super.key});
  static const routeName = '/createRecipe';

  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  late RecipeProvider recipe;

  @override
  void dispose() {
    super.dispose();
    recipe.clearRecipe(silent: true);
  }

  @override
  Widget build(BuildContext context) {
    recipe = Provider.of<RecipeProvider>(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Recipe'),
        ),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) => recipe.title = value,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                ),
                TextFormField(
                  onChanged: (value) => recipe.description = value,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                  ),
                ),
                DropdownMenu<Difficulty?>(
                  dropdownMenuEntries: DifficultyUtil.getDropdownList(),
                  onSelected: (value) => recipe.difficulty = value,
                  label: const Text('Difficulty'),
                ),
                ElevatedButton(
                  onPressed: _openIngredientBottomSheet,
                  child: const Text('Add Ingredient'),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: recipe.ingredients.length,
                    itemBuilder: _ingredientListBuilder,
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openIngredientBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => IngredientsBottomsheet(
        onSubmitted: _onIngredientSubmitted,
      ),
    );
  }

  void _onIngredientSubmitted(IngredientListEntry ingredient) => setState(() {
        recipe.ingredients.add(ingredient);
      });

  Widget? _ingredientListBuilder(BuildContext context, int index) {
    final ingredient = recipe.ingredients.elementAt(index);
    final textTheme = Theme.of(context).textTheme.titleMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(ingredient.ingredient.title, style: textTheme),
          Row(
            children: [
              Text(
                ingredient.amount.toString(),
                style: textTheme,
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
              Text(
                ingredient.unit.name,
                style: textTheme,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() {
    if (recipe.isEmpty) {
      return Future<bool>(
        () {
          return true;
        },
      );
    }
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Leave the page?'),
        content: const Text('Progress will be lost.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('cancel')),
          TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('leave')),
        ],
      ),
    ).then((value) => value ?? false);
  }
}
