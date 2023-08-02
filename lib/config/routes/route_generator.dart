import 'package:flutter/material.dart';
import 'package:muzzone/ui/widgets/layout_widgets/my_sliding_up_panel.dart';
import 'muzzone_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          if (settings.name == 'TabBarViewPage') {
            return MySlidingUpPanel(mainRoute: settings.name!);
          }

          return muzzoneRoutes[settings.name]!(context);
        });
  }
}
