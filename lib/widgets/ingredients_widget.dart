import 'package:flutter/material.dart';
import '../constants.dart' as constants;

class IngredientsWidget extends StatefulWidget {
  const IngredientsWidget({super.key, this.width});

  final double? width;

  @override
  State<IngredientsWidget> createState() => _IngredientsWidgetState();
}

class _IngredientsWidgetState extends State<IngredientsWidget> {
  late double width;
  int itemCount = 1;

  Widget _ingredientListBuilder(BuildContext context, int index) {
    if (index == itemCount) {
      return FloatingActionButton(
        onPressed: () => setState(() {
          itemCount++;
        }),
        child: const Icon(Icons.add),
      );
    }
    return Row(
      children: [
        SizedBox(
          width: width * 0.6,
          child: const TextField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              label: Text('Ingredient'),
            ),
          ),
        ),
        SizedBox(
          width: width * 0.2,
          child: const TextField(
            maxLines: 1,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              label: Text('Amount'),
            ),
          ),
        ),
        SizedBox(
          width: width * 0.2,
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              label: Text('Unit'),
            ),
            isDense: true,
            items: constants.units
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e.name,
                    child: SizedBox(
                      width: width * 0.135,
                      child: Text(e.name),
                    ),
                  ),
                )
                .toList(),
            onChanged: _onDropdownChanged,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    width = widget.width ?? MediaQuery.of(context).size.width;
    return Expanded(
      child: ListView.builder(
        itemCount: itemCount + 1,
        itemBuilder: _ingredientListBuilder,
      ),
    );
  }

  void _onDropdownChanged(value) {}
}
