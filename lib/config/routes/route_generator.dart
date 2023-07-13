import 'package:flutter/material.dart';
import 'muzzone_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    return MaterialPageRoute(
        settings: settings,
        builder: (context) => muzzoneRoutes[settings.name]!(context));
  }
}
