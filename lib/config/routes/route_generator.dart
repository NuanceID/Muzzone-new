import 'package:flutter/material.dart';

import '../utils/helpers.dart';
import 'muzzone_routes.dart';

class RouteGenerator {
  static const _id = 'RouteGenerator';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as dynamic;
    log(_id, msg: "Pushed ${settings.name}(${args ?? ''})");

    return PageRouteBuilder(
      transitionDuration: Duration.zero,
      pageBuilder: (context, animation, args) =>
          muzzoneRoutes[settings.name]!(context),
      settings: settings,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );
        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }

  // static MaterialPageRoute _route(Widget widget) =>
  //     MaterialPageRoute(builder: (context) => widget);
}
