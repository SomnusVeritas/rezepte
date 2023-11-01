import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart' as constants;
import '../models/ingredient.dart';
import '../models/ingredient_list_entry.dart';
import '../models/unit.dart';
import '../example_data.dart' as ea;
import '../services/providers/recipe_provider.dart';

typedef IngredientCallback = void Function(IngredientListEntry);

class IngredientsBottomsheet extends StatefulWidget {
  const IngredientsBottomsheet({required this.onSubmitted, super.key});

  final IngredientCallback onSubmitted;

  @override
  State<IngredientsBottomsheet> createState() => _IngredientsBottomsheetState();
}

class _IngredientsBottomsheetState extends State<IngredientsBottomsheet> {
  final List<DropdownMenuEntry<Ingredient>> ingredientEntries = [];
  late RecipeProvider recipeProvider;
  Unit? selectedUnit;
  final List<DropdownMenuEntry<Unit>> unitEntries = [];

  TextEditingController _amountController = TextEditingController();
  TextEditingController _ingredientController = TextEditingController();
  bool _isOptional = false;
  TextEditingController _unitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (var unit in constants.units) {
      unitEntries.add(DropdownMenuEntry(value: unit, label: unit.name));
    }
    for (var ingredient in ea.exampleIngredients) {
      ingredientEntries
          .add(DropdownMenuEntry(value: ingredient, label: ingredient.title));
    }
  }

  void onClosing() {}

  Widget _bottomSheetContent(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              DropdownMenu<Ingredient?>(
                dropdownMenuEntries: ingredientEntries,
                enableSearch: true,
                enableFilter: true,
                requestFocusOnTap: true,
                controller: _ingredientController,
                label: const Text('Ingredient'),
                textStyle:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      maxLines: 1,
                      controller: _amountController,
                      onTapOutside: (_) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        label: Text('Amount'),
                      ),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                  DropdownMenu<Unit?>(
                    label: const Text('Unit'),
                    width: 150,
                    requestFocusOnTap: false,
                    controller: _unitController,
                    dropdownMenuEntries: unitEntries,
                    enableSearch: false,
                    enableFilter: false,
                    onSelected: (unit) => setState(() {
                      selectedUnit = unit;
                    }),
                    textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'optional',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  Checkbox(
                    value: _isOptional,
                    onChanged: (_) =>
                        setState(() => _isOptional = !_isOptional),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 200,
          width: 400,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _cancelTapped,
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: _finishTapped,
                child: const Text('Finish'),
              ),
              TextButton(
                onPressed: _nextTapped,
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _nextTapped() {
    final success = _submit();
    if (success) {
      setState(() {
        _ingredientController.value = TextEditingValue.empty;
        _unitController.value = TextEditingValue.empty;
        _amountController.value = TextEditingValue.empty;
        _isOptional = false;
        selectedUnit = null;
      });
    }
  }

  void _finishTapped() {
    final success = _submit();
    if (success) {
      Navigator.of(context).pop();
    }
  }

  void _cancelTapped() {
    Navigator.of(context).pop();
  }

  bool _submit() {
    final ingredient = Ingredient(title: _ingredientController.text);
    final unit = selectedUnit;
    final amount = int.tryParse(_amountController.text);
    if (ingredient.title.isEmpty || unit == null || amount == null) {
      return false;
    }

    final newEntry = IngredientListEntry(ingredient, amount, unit, _isOptional);
    widget.onSubmitted(newEntry);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    recipeProvider = Provider.of<RecipeProvider>(context);
    return BottomSheet(
      onClosing: onClosing,
      builder: _bottomSheetContent,
    );
  }
}
