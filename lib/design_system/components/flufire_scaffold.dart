import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/color_palette.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/images.dart';

class FlufireScaffold extends StatelessWidget {
  final Widget child;
  const FlufireScaffold({
    Key? key,
    required this.child,
    this.hasBackButton = true,
  }) : super(key: key);

  final bool hasBackButton;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: ColorPalette.primaryColor),
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
            child,
          ],
        ),
      ),
    );
  }
}
