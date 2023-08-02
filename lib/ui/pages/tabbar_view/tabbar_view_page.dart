import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzzone/config/routes/muzzone_nested_routes.dart';
import 'package:muzzone/config/utils/globals.dart';
import 'package:muzzone/logic/blocs/bottom_navigation_bar/bottom_navigation_bar_bloc.dart';
import 'package:muzzone/logic/blocs/bottom_navigation_bar/bottom_navigation_bar_event.dart';
import 'package:muzzone/ui/pages/main_page/view/main_page.dart';
import 'package:muzzone/ui/pages/my_media_page/view/my_media_page.dart';
import 'package:muzzone/ui/pages/search/view/search_page.dart';

class TabBarViewPage extends StatefulWidget {
  const TabBarViewPage({super.key});

  static const id = 'TabBarViewPage';

  @override
  State<TabBarViewPage> createState() => _TabBarViewPageState();
}

class _TabBarViewPageState extends State<TabBarViewPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    BlocProvider.of<BottomNavigationBarBloc>(context)
        .add(SetTabController(tabController: _tabController));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          Navigator(
            key: Globals.kMainNestedNavigatorKey,
            initialRoute: MainPage.id,
            onGenerateRoute: (settings) {
              return MaterialPageRoute<dynamic>(
                settings: settings,
                builder: (context) =>
                    muzzoneNestedRoutes[settings.name]!(context),
              );
            },
          ),
          Navigator(
            key: Globals.kSearchNestedNavigatorKey,
            initialRoute: SearchPage.id,
            onGenerateRoute: (settings) {
              return MaterialPageRoute<dynamic>(
                settings: settings,
                builder: (context) =>
                    muzzoneNestedRoutes[settings.name]!(context),
              );
            },
          ),
          Navigator(
            key: Globals.kMyMediaNestedNavigatorKey,
            initialRoute: MyMediaPage.id,
            onGenerateRoute: (settings) {
              return MaterialPageRoute<dynamic>(
                settings: settings,
                builder: (context) =>
                    muzzoneNestedRoutes[settings.name]!(context),
              );
            },
          )
        ],
      ),
    );
  }
}
