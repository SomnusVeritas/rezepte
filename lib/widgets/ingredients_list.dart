import 'package:flutter/material.dart';

class IngredientsList extends StatefulWidget {
  const IngredientsList({super.key});

  @override
  State<IngredientsList> createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: _ingredientsBuilder,
      ),
    );
  }

  Widget? _ingredientsBuilder(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: screenWidth / 4,
          child: const TextField(
            decoration: InputDecoration(
              label: Text('Ingredient'),
            ),
          ),
        ),
        SizedBox(
          width: screenWidth / 4,
          child: const TextField(
            decoration: InputDecoration(
              label: Text('Count'),
            ),
          ),
        ),
      ],
    );
  }
}
