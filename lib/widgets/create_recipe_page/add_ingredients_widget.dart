import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/ingredient_list_entry.dart';
import '../../models/recipe.dart';
import '../../services/providers/recipe_provider.dart';
import '../../widgets/ingredients_bottomsheet.dart';

class AddIngredientsWidget extends StatefulWidget {
  const AddIngredientsWidget({super.key});

  @override
  State<AddIngredientsWidget> createState() => _AddIngredientsWidgetState();
}

class _AddIngredientsWidgetState extends State<AddIngredientsWidget> {
  late RecipeProvider recipeProvider;

  void _onIngredientRemoveTapped(int index) {
    final removedIngredient =
        recipeProvider.recipe!.ingredients.elementAt(index);

    setState(() {
      recipeProvider.recipe!.removeIngredientAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Ingredient Removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              recipeProvider.recipe!.addIngredient(removedIngredient);
            });
          },
        ),
      ),
    );
  }

  Widget? _ingredientListBuilder(BuildContext context, int index) {
    final ingredient = recipeProvider.recipe!.ingredients.elementAt(index);

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

  void _openIngredientBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => IngredientsBottomsheet(
        onSubmitted: _onIngredientSubmitted,
      ),
    );
  }

  void _onIngredientSubmitted(IngredientListEntry ingredient) => setState(() {
        recipeProvider.recipe!.ingredients.add(ingredient);
      });

  @override
  Widget build(BuildContext context) {
    recipeProvider = Provider.of<RecipeProvider>(context, listen: true);
    if (recipeProvider.recipe == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Stack(
      children: [
        ListView.separated(
          padding: const EdgeInsets.only(bottom: 88),
          itemCount: recipeProvider.recipe!.ingredients.length,
          itemBuilder: _ingredientListBuilder,
          separatorBuilder: (context, index) => const Divider(),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16, right: 16),
            child: FloatingActionButton(
              onPressed: _openIngredientBottomSheet,
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}
