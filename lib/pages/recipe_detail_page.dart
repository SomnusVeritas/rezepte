import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rezepte/services/providers/recipe_provider.dart';

import '../models/recipe.dart';

class RecipeDetail extends StatelessWidget {
  const RecipeDetail({super.key});
  static const routeName = '/recipeDetail';

  @override
  Widget build(BuildContext context) {
    final recipe = Provider.of<RecipeProvider>(context, listen: false).recipe;

    if (recipe == null) Navigator.of(context).pop();
    recipe as Recipe;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(recipe.title),
      ),
    );
  }
}
