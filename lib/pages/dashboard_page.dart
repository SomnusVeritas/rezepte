import 'package:flutter/material.dart';
import 'package:rezepte/pages/create_recipe_page.dart';
import 'package:rezepte/widgets/recipe_list.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  static const routeName = '/';

  void _onAddTapped(BuildContext context) =>
      Navigator.of(context).pushNamed(CreateRecipe.routeName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddTapped(context),
        child: const Icon(Icons.add),
      ),
      body: const RecipeList(),
    );
  }
}
