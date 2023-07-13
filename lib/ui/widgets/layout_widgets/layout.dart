import 'package:flutter/material.dart';
import 'package:muzzone/ui/widgets/widgets.dart';

class Layout extends StatelessWidget {
  final Widget? child;

  const Layout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            extendBody: false,
            body: MySlidingUpPanel(
              child: child ?? const SizedBox.shrink(),
            ),),
      ),
    );
  }
}
