import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/color_palette.dart';

class LinkButton extends StatelessWidget {
  const LinkButton({
    Key? key,
    required this.text,
    this.boldText,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final String? boldText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(text),
          if (boldText != null)
            Text(
              boldText!,
              style: const TextStyle(
                color: ColorPalette.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
