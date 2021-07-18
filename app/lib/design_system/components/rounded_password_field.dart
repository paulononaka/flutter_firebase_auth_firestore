import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/color_palette.dart';

import 'text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  const RoundedPasswordField({
    Key? key,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        obscureText: true,
        onChanged: onChanged,
        cursorColor: ColorPalette.primaryColor,
        decoration: const InputDecoration(
          hintText: "Password",
          icon: Icon(Icons.lock, color: ColorPalette.primaryColor),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
