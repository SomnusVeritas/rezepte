import 'package:flutter/material.dart';

import '../models/difficulty.dart';

typedef Intcallback = void Function(int);

class DifficultyDropdown extends StatelessWidget {
  const DifficultyDropdown({super.key, this.onChanged});
  final Intcallback? onChanged;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry<Difficulty>> dropdownMenuEntryList =
        Difficulty.values.map((e) => _toDropdownMenuEntry(e, e.name)).toList();

    return DropdownMenu<Difficulty?>(
      dropdownMenuEntries: dropdownMenuEntryList,
      onSelected: (value) {
        if (onChanged != null) {
          onChanged!(value?.index ?? -1);
        }
      },
    );
  }

  DropdownMenuEntry<Difficulty> _toDropdownMenuEntry(
          Difficulty difficulty, String text) =>
      DropdownMenuEntry(value: difficulty, label: text);
}
