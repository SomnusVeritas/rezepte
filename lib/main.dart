import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rezepte/pages/create_recipe_page.dart';
import 'package:rezepte/pages/dashboard_page.dart';
import 'package:rezepte/services/providers/recipe_list_provider.dart';
import 'package:rezepte/services/providers/recipe_provider.dart';

import 'pages/recipe_detail_page.dart';
import 'theme.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => RecipeListProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => RecipeProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      routes: {
        Dashboard.routeName: (_) => const Dashboard(),
        CreateRecipe.routeName: (_) => const CreateRecipe(),
        RecipeDetail.routeName: (_) => const RecipeDetail(),
      },
    );
  }
}
