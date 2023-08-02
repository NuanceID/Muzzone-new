import 'package:flutter/material.dart';

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
            resizeToAvoidBottomInset: true,
            extendBody: false,
            body: child ?? const SizedBox.shrink()),
      ),
    );
  }
}
