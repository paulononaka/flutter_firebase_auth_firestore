import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/auth/auth_manager.dart';
import 'package:flutter_firebase_auth_firestore/pages/home/home_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/order/order_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/profile/profile_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/sign_in/sign_in_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/sign_up/sign_up_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/test_details/test_details_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/tests/tests_page.dart';
import 'package:flutter_firebase_auth_firestore/pages/welcome/welcome_page.dart';
import 'package:get_it/get_it.dart';

class Routes {
  static const welcome = 'welcome';
  static const signUp = 'sign_up';
  static const signIn = 'sign_in';
  static const home = 'home';
  static const order = 'order';
  static const tests = 'tests';
  static const testDetails = 'test_details';
  static const profile = 'profile';
}

class AppNavigator extends StatefulWidget {
  AppNavigator({Key? key, required this.authManager}) : super(key: key);

  final AuthManager authManager;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<StatefulWidget> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  @override
  Widget build(BuildContext context) {
    widget.authManager.didLogout(_logout);

    final getIt = GetIt.I;

    return Navigator(
      key: widget.navigatorKey,
      initialRoute: initialRoute(),
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case Routes.welcome:
            builder = (BuildContext _) => getIt.get<WelcomePage>();
            break;
          case Routes.signIn:
            builder = (BuildContext _) => getIt.get<SignInPage>();
            break;
          case Routes.signUp:
            builder = (BuildContext _) => getIt.get<SignUpPage>();
            break;
          case Routes.home:
            builder = (BuildContext _) => getIt.get<HomePage>();
            break;
          case Routes.order:
            builder = (BuildContext _) => getIt.get<OrderPage>();
            break;
          case Routes.tests:
            builder = (BuildContext _) => getIt.get<TestsPage>();
            break;
          case Routes.testDetails:
            builder = (BuildContext _) => getIt.get<TestDetailsPage>();
            break;
          case Routes.profile:
            builder = (BuildContext _) => getIt.get<ProfilePage>();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }

  String initialRoute() {
    if (widget.authManager.isLoggedIn) {
      return Routes.home;
    } else {
      return Routes.welcome;
    }
  }

  void _logout(bool hasLoggedOut) {
    if (hasLoggedOut) {
      widget.navigatorKey.currentState?.pushNamedAndRemoveUntil(Routes.welcome, (_) => false);
    }
  }
}
