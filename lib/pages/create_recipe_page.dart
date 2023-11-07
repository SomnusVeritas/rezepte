import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rezepte/widgets/ingredients_bottomsheet.dart';
import 'package:rezepte/widgets/will_pop_scope.dart';
import '../models/difficulty.dart';
import '../models/ingredient_list_entry.dart';
import '../models/recipe.dart';
import '../services/providers/recipe_list_provider.dart';
import '../services/providers/recipe_provider.dart';

class CreateRecipe extends StatefulWidget {
  const CreateRecipe({super.key});
  static const routeName = '/createRecipe';

  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  late RecipeListProvider recipeListProvider;
  late RecipeProvider recipeProvider;
  late Recipe recipe;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    recipeProvider.disposeRecipe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    recipe = Provider.of<RecipeProvider>(context).recipe;
    recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
    recipeListProvider =
        Provider.of<RecipeListProvider>(context, listen: false);
    return CustomWillPopScope(
      context,
      ignore: recipe.isEmpty,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Recipe'),
        ),
        floatingActionButton: recipe.isNotEmpty
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
                  onChanged: (value) => recipe.title = value,
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
                  onChanged: (value) => recipe.description = value,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                  ),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                DropdownMenu<Difficulty>(
                  dropdownMenuEntries: DifficultyUtil.getDropdownList(),
                  onSelected: (value) =>
                      recipe.difficulty = value ?? Difficulty.notSelected,
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

  void _onIngredientRemoveTapped(int index) {
    final removedIngredient = recipe.ingredients.elementAt(index);

    recipe.removeIngredientAt(index);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Ingredient Removed'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              recipe.addIngredient(removedIngredient);
            }),
      ),
    );
  }

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

  void _onRecipeSubmitted() {
    // TODO implement onRecipeSubmitted
    if (recipe.isEmpty) return;
    recipeListProvider.addRecipe(recipe);
    Navigator.of(context).pop();
  }
}
