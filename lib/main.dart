import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/color_palette.dart';
import 'package:flutter_firebase_auth_firestore/navigation/app_navigator.dart';
import 'package:get_it/get_it.dart';
import 'design_system/tokens/text_theme.dart';
import 'di/container.dart' as di;

void main() {
  di.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextStyles.textTheme,
        primaryColor: ColorPalette.primaryColor,
        scaffoldBackgroundColor: ColorPalette.background,
      ),
      builder: (BuildContext _, Widget? __) => GetIt.I.get<AppNavigator>(),
    );
  }
}
