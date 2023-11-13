import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rezepte/services/providers/db/dbhelper.dart';
import 'package:rezepte/widgets/will_pop_scope.dart';
import '../models/recipe.dart';
import '../services/providers/recipe_list_provider.dart';
import '../services/providers/recipe_provider.dart';
import '../widgets/create_recipe_page/add_info_widget.dart';
import '../widgets/create_recipe_page/add_ingredients_widget.dart';
import '../widgets/create_recipe_page/add_steps_widget.dart';

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
  final List<Widget> pages = [
    const AddRecipeInfoWidget(),
    const AddIngredientsWidget(),
    const AddCookingStepsWidget(),
  ];
  int selectedTabIndex = 0;

  @override
  void dispose() {
    recipeProvider.disposeRecipe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    recipeProvider = Provider.of<RecipeProvider>(context, listen: true);
    recipeListProvider =
        Provider.of<RecipeListProvider>(context, listen: false);

    if (recipeProvider.recipe == null) {
      recipe = Recipe(id: DbHelper.nextRecipeId, title: '');
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        recipeProvider.recipe = recipe;
      });
    }

    return CustomWillPopScope(
      context,
      ignore: recipe.isEmpty,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Recipe'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedTabIndex,
          showSelectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.add_task), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.add_task), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.add_task), label: ''),
          ],
          onTap: (value) => setState(() => selectedTabIndex = value),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: pages.elementAt(selectedTabIndex),
        ),
        // floatingActionButton: recipe.isNotEmpty
        //     ? FloatingActionButton(
        //         onPressed: _onRecipeSubmitted,
        //         child: const Icon(Icons.save),
        //       )
        //     : null,
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
