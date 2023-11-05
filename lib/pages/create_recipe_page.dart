import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rezepte/widgets/ingredients_bottomsheet.dart';
import 'package:rezepte/widgets/will_pop_scope.dart';
import '../models/difficulty.dart';
import '../models/ingredient_list_entry.dart';
import '../services/providers/recipe_list_provider.dart';
import '../services/providers/recipe_provider.dart';

class CreateRecipe extends StatefulWidget {
  const CreateRecipe({super.key});
  static const routeName = '/createRecipe';

  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  late RecipeProvider recipeProvider;
  late RecipeListProvider recipeListProvider;

  @override
  void dispose() {
    super.dispose();
    recipeProvider.clearRecipe(silent: true);
  }

  @override
  Widget build(BuildContext context) {
    recipeProvider = Provider.of<RecipeProvider>(context);
    recipeListProvider =
        Provider.of<RecipeListProvider>(context, listen: false);
    return CustomWillPopScope(
      context,
      ignore: recipeProvider.isEmpty,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Recipe'),
        ),
        floatingActionButton: recipeProvider.isNotEmpty
            ? FloatingActionButton(
                onPressed: _onRecipeSubmitted,
                child: const Icon(Icons.save),
              )
            : null,
        body: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextFormField(
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  onChanged: (value) => recipeProvider.title = value,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                TextFormField(
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  minLines: 1,
                  maxLines: 4,
                  onChanged: (value) => recipeProvider.description = value,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                  ),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                DropdownMenu<Difficulty?>(
                  dropdownMenuEntries: DifficultyUtil.getDropdownList(),
                  onSelected: (value) => recipeProvider.difficulty = value,
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
                    itemCount: recipeProvider.ingredients.length,
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
        recipeProvider.ingredients.add(ingredient);
      });

  void _onIngredientRemoveTapped(int index) {
    final removedIngredient = recipeProvider.ingredients.elementAt(index);

    recipeProvider.removeIngredientAt(index);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Ingredient Removed'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              recipeProvider.addIngredient(removedIngredient);
            }),
      ),
    );
  }

  Widget? _ingredientListBuilder(BuildContext context, int index) {
    final ingredient = recipeProvider.ingredients.elementAt(index);

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

  void _onRecipeSubmitted() {
    // TODO implement onRecipeSubmitted
    if (recipeProvider.isEmpty) return;
    recipeListProvider.addRecipe(recipeProvider.recipe);
    Navigator.of(context).pop();
  }
}
