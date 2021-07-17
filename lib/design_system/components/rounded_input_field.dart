import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/color_palette.dart';

import 'text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  const RoundedInputField({
    Key? key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  final String? hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: ColorPalette.primaryColor,
        decoration: InputDecoration(
          icon: Icon(icon, color: ColorPalette.primaryColor),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
