import 'package:flutter/material.dart';

class CreateRecipe extends StatelessWidget {
  const CreateRecipe({super.key});
  static const routeName = '/createRecipe';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Recipe'),
      ),
    );
  }
}
