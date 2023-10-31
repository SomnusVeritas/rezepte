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
  late RecipeProvider recipeProvider;
  final List<IngredientListEntry> ingredientEntries = [];

  @override
  Widget build(BuildContext context) {
    recipeProvider = Provider.of<RecipeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Recipe'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                label: const Text('Difficulty'),
              ),
              ElevatedButton(
                onPressed: _openIngredientBottomSheet,
                child: const Text('Add Ingredient'),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: ingredientEntries.length,
                  itemBuilder: _ingredientListBuilder,
                  separatorBuilder: (context, index) => const Divider(),
                ),
              )
            ],
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
        ingredientEntries.add(ingredient);
      });

  Widget? _ingredientListBuilder(BuildContext context, int index) {
    final ingredient = ingredientEntries.elementAt(index);
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

  Widget _seperatorBuilder(BuildContext context, int index) {
    return const Divider(indent: 20, endIndent: 20);
  }
}
