import 'package:flutter/material.dart';

import '../models/difficulty.dart';

typedef Intcallback = void Function(int);

class DifficultyDropdown extends StatelessWidget {
  const DifficultyDropdown({super.key, this.onChanged});
  final Intcallback? onChanged;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry> dropdownMenuEntryList = DifficultyUtil.difficulties
        .map((e) =>
            _toDropdownMenuEntry(DifficultyUtil.difficulties.indexOf(e), e))
        .toList();

    return DropdownMenu(
      dropdownMenuEntries: dropdownMenuEntryList,
      onSelected: (value) {
        if (onChanged != null) {
          onChanged!(value as int);
        }
      },
    );
  }

  DropdownMenuEntry _toDropdownMenuEntry(int index, String text) =>
      DropdownMenuEntry(value: index, label: text);
}
