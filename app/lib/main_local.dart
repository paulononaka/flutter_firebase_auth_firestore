import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'di/container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.setup(baseUrl: Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000');
  runApp(const App());
}
