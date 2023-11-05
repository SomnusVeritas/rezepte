import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rezepte/services/providers/recipe_list_provider.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({super.key});

  @override
  Widget build(BuildContext context) {
    final recipes =
        Provider.of<RecipeListProvider>(context, listen: true).recipes;
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: _recipeListBuilder,
    );
  }

  Widget? _recipeListBuilder(BuildContext context, int index) {
    return Card();
  }
}
