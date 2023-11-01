import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rezepte/widgets/ingredients_bottomsheet.dart';
import 'package:rezepte/widgets/will_pop_scope.dart';
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
    return CustomWillPopScope(
      context,
      ignore: recipe.isEmpty,
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
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                TextFormField(
                  onChanged: (value) => recipe.description = value,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                  ),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                DropdownMenu<Difficulty?>(
                  dropdownMenuEntries: DifficultyUtil.getDropdownList(),
                  onSelected: (value) => recipe.difficulty = value,
                  label: const Text('Difficulty'),
                  textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
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

  void _onIngredientRemoveTapped(int index) {}

  Widget? _ingredientListBuilder(BuildContext context, int index) {
    final ingredient = recipe.ingredients.elementAt(index);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(ingredient.ingredient.title),
      subtitle: ingredient.optional ? const Text('optional') : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            ingredient.amount.toString(),
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
          Text(
            ingredient.unit.name,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
          SizedBox(
            width: 30,
            height: 30,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => _onIngredientRemoveTapped(index),
              icon: const Icon(Icons.delete),
            ),
          ),
        ],
      ),
    );
  }
}
