import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/color_palette.dart';

import 'text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  const RoundedInputField({
    Key? key,
    this.hint,
    this.showCursor = true,
    this.icon = Icons.person,
    this.onChanged,
    this.controller,
    this.onPressed,
  }) : super(key: key);

  final bool showCursor;
  final String? hint;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onTap: onPressed,
        controller: controller,
        showCursor: showCursor,
        onChanged: onChanged,
        cursorColor: ColorPalette.primaryColor,
        decoration: InputDecoration(
          icon: Icon(icon, color: ColorPalette.primaryColor),
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
