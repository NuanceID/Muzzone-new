import 'package:flutter/material.dart';
import 'package:muzzone/ui/widgets/widgets.dart';

class Layout extends StatelessWidget {
  final Widget? child;
  final GlobalKey<NavigatorState> kNavigatorKey;

  const Layout({Key? key, required this.child, required this.kNavigatorKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          top: false,
          bottom: false,
          child: Container(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: Stack(
              children: [
                MySlidingUpPanel(
                    kNavigatorKey: kNavigatorKey, child: child ?? Container())
              ],
            ),
          ),
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            BottomBar(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
