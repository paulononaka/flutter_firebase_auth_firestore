import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/auth/auth_manager.dart';
import 'package:flutter_firebase_auth_firestore/pages/home/home_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/sign_up/sign_up_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/welcome/welcome_page.dart';
import 'package:get_it/get_it.dart';

class Routes {
  static const welcome = 'welcome';
  static const signUp = 'sign_up';
  static const home = 'home';
}

class AppNavigator extends StatelessWidget {
  const AppNavigator({final Key? key, required this.authManager}) : super(key: key);

  final AuthManager authManager;

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.I;

    return Navigator(
      initialRoute: initialRoute(),
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case Routes.welcome:
            builder = (BuildContext _) => getIt.get<WelcomePage>();
            break;
          case Routes.signUp:
            builder = (BuildContext _) => getIt.get<SignUpPage>();
            break;
          case Routes.home:
            builder = (BuildContext _) => getIt.get<HomePage>();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }

  String initialRoute() {
    if (authManager.isLoggedIn) {
      return Routes.home;
    } else {
      return Routes.welcome;
    }
  }
}
