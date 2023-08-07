import 'package:flutter/material.dart';

class Routes {
  static const String initialRoute = '/';
}

class AppRoute {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        //return pageRoute(const );
        break;
      default:
    }
  }
}

pageRoute(Widget screen, Object? arguments) {
  return MaterialPageRoute(
      builder: (_) => screen, settings: RouteSettings(arguments: arguments));
}

notDefine() {
  return MaterialPageRoute(
      builder: (_) => const Scaffold(
            body: Center(child: Text('Not defined')),
          ));
}
