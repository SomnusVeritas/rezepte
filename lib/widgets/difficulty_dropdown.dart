import 'package:flutter/material.dart';

import '../models/difficulty.dart';

class DifficultyDropdown extends StatelessWidget {
  const DifficultyDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry> dropdownMenuEntryList = Difficulty.difficulties
        .map(
          (e) => _toDropdownMenuEntry(Difficulty.difficulties.indexOf(e), e),
        )
        .toList();

    return DropdownMenu(
      dropdownMenuEntries: dropdownMenuEntryList,
    );
  }

  DropdownMenuEntry _toDropdownMenuEntry(int index, String text) =>
      DropdownMenuEntry(value: index, label: text);
}
