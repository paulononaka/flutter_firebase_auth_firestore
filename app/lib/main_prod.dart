import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'di/container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.setup(baseUrl: 'https://europe-west2-flutfire-e08a4.cloudfunctions.net/api');
  runApp(const App());
}
