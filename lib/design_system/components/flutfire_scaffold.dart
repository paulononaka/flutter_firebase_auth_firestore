import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/color_palette.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/images.dart';

import 'link_button.dart';

class FlutfireScaffold extends StatelessWidget {
  final Widget child;
  const FlutfireScaffold({
    Key? key,
    required this.child,
    this.title,
    this.hasBackButton = true,
    this.logoutOnPressed,
  }) : super(key: key);

  final bool hasBackButton;
  final VoidCallback? logoutOnPressed;
  final String? title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: (title != null)
            ? Text(
                title!,
                style: const TextStyle(
                  color: ColorPalette.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
        iconTheme: const IconThemeData(color: ColorPalette.primaryColor),
        actions: logoutOnPressed != null
            ? [
                LinkButton(
                  text: ' Sair ',
                  textColor: ColorPalette.primaryColor,
                  onPressed: logoutOnPressed!,
                ),
              ]
            : null,
      ),
      body: SizedBox(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: SizedBox(height: size.width * 0.3, child: Images.mainTop),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(height: size.width * 0.3, child: Images.mainBottom),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
