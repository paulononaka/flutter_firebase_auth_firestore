import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/pages/home/home_page.dart';
import 'package:get_it/get_it.dart';

class Routes {
  static const home = 'app/home';
}

class AppNavigator extends StatelessWidget {
  const AppNavigator({final GlobalKey<NavigatorState>? key})
      : _navigatorKey = key,
        super(key: key);

  final GlobalKey<NavigatorState>? _navigatorKey;

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.I;

    return Navigator(
      key: _navigatorKey,
      initialRoute: initialRoute(),
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
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
    return Routes.home;
  }
}
