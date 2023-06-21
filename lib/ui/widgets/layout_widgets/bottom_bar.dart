import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/generated/locale_keys.g.dart';
import 'package:muzzone/logic/functions/navigate_with_nav_key.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config.dart';
import '../../../logic/blocs/bottom_bar/bottom_bar_bloc.dart';
import '../../pages/main_page/view/main_page.dart';
import '../../pages/my_music/view/my_media_library_page.dart';
import '../../pages/search/view/search_page.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBarBloc, BottomBarState>(
      builder: (context, state) {
        if (state.visible) {
          return Container(
            height: state.height == 0 || state.height == 100
                ? Space.bottomBarHeight
                : state.height,
            width: 100.w,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                top: BorderSide(
                  color: Colors.grey.withOpacity(0.1),
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              children: [
                _Tab(
                  icon: icons[0],
                  index: 0,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  label: LocaleKeys.main_name_first_screen.tr(),
                  onPress: () => navigateWithNavigatorKey(
                      MainPage.id, context, Globals.kNavigatorKey, true),
                ),
                _Tab(
                    icon: icons[1],
                    index: 1,
                    label: LocaleKeys.main_name_second_screen.tr(),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    onPress: () => navigateWithNavigatorKey(
                        SearchPage.id, context, Globals.kNavigatorKey, true)),
                _Tab(
                  icon: icons[2],
                  index: 2,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  label: LocaleKeys.main_name_third_screen.tr(),
                  onPress: () => navigateWithNavigatorKey(MyMediaLibraryPage.id,
                      context, Globals.kNavigatorKey, true),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class _Tab extends StatelessWidget {
  _Tab({
    Key? key,
    required this.index,
    required this.label,
    required this.icon,
    required this.onPress,
    this.color,
  }) : super(key: key);

  final int index;
  final String label;
  final String icon;
  final VoidCallback onPress;
  final Color? color;

  final bottomBarBloc = GetIt.I.get<BottomBarBloc>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (bottomBarBloc.state.canUse ||
            bottomBarBloc.state.activeIndex != index) {
          bottomBarBloc.add(ChangeBottomBarItemEvent(index));
          onPress();
        }
      },
      child: Container(
        padding: EdgeInsets.only(
            left: index == 0 ? 10.w : 0, right: index == 2 ? 10.w : 0),
        width: index == 1 ? 28.w : 36.w,
        color: color,
        child: Stack(
          children: [
            Positioned(
              top: 1.3.h,
              bottom: null,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                icon,
                color: bottomBarBloc.state.activeIndex == index
                    ? AppColors.primaryColor
                    : Theme.of(context).cardColor,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: null,
              bottom: 1.3.h,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: bottomBarBloc.state.activeIndex == index
                        ? AppColors.primaryColor
                        : Theme.of(context).cardColor,
                    fontSize: 1.2.h,
                  ),
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
