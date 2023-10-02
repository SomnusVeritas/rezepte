import 'package:flutter/material.dart';
import 'package:rezepte/models/recipe.dart';

class DifficultyDropdown extends StatelessWidget {
  const DifficultyDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry> dropdownMenuEntryList = List.generate(
        Difficulty.values.length,
        (index) => _toDropdownMenuEntry(
            index, Difficulty.values.elementAt(index).name));

    return DropdownMenu(
      dropdownMenuEntries: dropdownMenuEntryList,
    );
  }

  DropdownMenuEntry _toDropdownMenuEntry(int index, String text) =>
      DropdownMenuEntry(value: index, label: text);
}
