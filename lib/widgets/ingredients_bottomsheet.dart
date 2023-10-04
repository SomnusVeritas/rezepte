import 'package:flutter/material.dart';
import '../constants.dart' as constants;
import '../models/ingredient.dart';
import '../models/unit.dart';
import '../example_data.dart' as ea;

class IngredientsBottomsheet extends StatefulWidget {
  const IngredientsBottomsheet({super.key});

  @override
  State<IngredientsBottomsheet> createState() => _IngredientsBottomsheetState();
}

class _IngredientsBottomsheetState extends State<IngredientsBottomsheet> {
  TextEditingController dropdownController = TextEditingController();
  final List<DropdownMenuEntry<Unit>> unitEntries = [];
  final List<DropdownMenuEntry<Ingredient>> ingredientEntries = [];
  Unit? selectedUnit;
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: onClosing,
      builder: _bottomSheetContent,
    );
  }

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
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 10,
        right: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: DropdownMenu<Ingredient>(
                  dropdownMenuEntries: ingredientEntries,
                  enableSearch: true,
                  enableFilter: true,
                  requestFocusOnTap: true,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  maxLines: 1,
                  onTapOutside: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    label: Text('Amount'),
                  ),
                ),
              ),
              DropdownMenu<Unit>(
                label: const Text('Unit'),
                width: 150,
                requestFocusOnTap: true,
                controller: dropdownController,
                dropdownMenuEntries: unitEntries,
                onSelected: (unit) => setState(() {
                  selectedUnit = unit;
                }),
              )
            ],
          )
        ],
      ),
    );
  }
}
