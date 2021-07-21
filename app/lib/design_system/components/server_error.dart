import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/images.dart';

import 'flutfire_scaffold.dart';

class ServerError extends StatelessWidget {
  const ServerError({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FlutfireScaffold(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.2),
            Text(errorMessage, style: const TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: size.height * 0.03),
            SizedBox(height: size.height * 0.2, child: Images.error),
          ],
        ),
      ),
    );
  }
}
