import 'package:flutter/material.dart';

import 'text_field_container.dart';

class DropdownField extends StatefulWidget {
  const DropdownField({Key? key, required this.list, this.onChanged}) : super(key: key);

  final List<String> list;
  final ValueChanged<String>? onChanged;

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  String? value;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: DropdownButton<String>(
        hint: const Text('Choose'),
        value: value,
        isExpanded: true,
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              value = newValue;
            });
            if (widget.onChanged != null) widget.onChanged!(newValue);
          }
        },
        items: widget.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
