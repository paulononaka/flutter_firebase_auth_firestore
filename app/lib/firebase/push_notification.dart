import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/color_palette.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  debugPrint(message.toString());

  if (message.containsKey('data')) {
    final dynamic data = message['data'];
    debugPrint('message.data: $data');
  }

  if (message.containsKey('notification')) {
    final dynamic notification = message['notification'];
    debugPrint('message.notification: $notification');
  }

  return Future<void>.value();
}

class PushNotification {
  final FirebaseMessaging _cloudMessaging = FirebaseMessaging.instance;
  final _updateHome = StreamController<Map<String, dynamic>>.broadcast();

  Future<String?> get deviceToken async => await _cloudMessaging.getToken();

  Future<void> setup() async {
    _cloudMessaging.getToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(message.toString());
      _updateHome.add(message.data);

      RemoteNotification? notification = message.notification;
      if (notification != null) {
        Fluttertoast.showToast(
            msg: message.notification!.body!,
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 5,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: ColorPalette.primaryColor,
            textColor: Colors.white,
            fontSize: 20.0);
      }
    });
  }

  void onHomeUpdate(void Function(Map<String, dynamic> message) listen) {
    _updateHome.stream.listen(listen);
  }

  Future<void> requestPermissions() async {
    await _cloudMessaging.requestPermission();
  }
}
