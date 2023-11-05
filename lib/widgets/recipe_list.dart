import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rezepte/pages/recipe_detail_page.dart';
import 'package:rezepte/services/providers/recipe_list_provider.dart';
import 'package:rezepte/services/providers/recipe_provider.dart';

import '../models/recipe.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({super.key});

  @override
  Widget build(BuildContext context) {
    final recipes =
        Provider.of<RecipeListProvider>(context, listen: true).recipes;

    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) =>
          _recipeListBuilder(context, index, recipes.elementAt(index)),
    );
  }

  Widget? _recipeListBuilder(BuildContext context, int index, Recipe entry) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _onRecipeTapped(context, entry),
        child: ListTile(
          title: Text(entry.title),
        ),
      ),
    );
  }

  void _onRecipeTapped(BuildContext context, Recipe recipe) {
    Provider.of<RecipeProvider>(context, listen: false).recipe = recipe;
    Navigator.of(context).pushNamed(RecipeDetail.routeName);
  }
}
