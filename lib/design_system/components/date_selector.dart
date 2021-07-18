import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'rounded_input_field.dart';

class DateSelectorField extends StatefulWidget {
  const DateSelectorField({Key? key, this.hint, this.onChanged}) : super(key: key);

  final String? hint;
  final ValueChanged<DateTime>? onChanged;

  @override
  State<DateSelectorField> createState() => _DateSelectorFieldState();
}

class _DateSelectorFieldState extends State<DateSelectorField> {
  final TextEditingController controller = TextEditingController();
  DateTime selectedDate = DateTime(1990, 1);
  final DateFormat formatter = DateFormat('MM-dd-yyyy');

  @override
  Widget build(BuildContext context) {
    return RoundedInputField(
      hint: widget.hint,
      showCursor: false,
      controller: controller,
      onPressed: _selectDate,
    );
  }

  Future<void> _selectDate() async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1930, 1),
        lastDate: DateTime(now.year - 15, now.month, now.day));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        controller.text = formatter.format(picked);
        if (widget.onChanged != null) widget.onChanged!(picked);
      });
    }
  }
}
