import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzone/config/constants/constants.dart';
import 'package:muzzone/config/style/style.dart';
import 'package:muzzone/generated/locale_keys.g.dart';
import 'package:muzzone/logic/blocs/bottom_navigation_bar/bottom_navigation_bar_bloc.dart';
import 'package:muzzone/logic/blocs/bottom_navigation_bar/bottom_navigation_bar_event.dart';
import 'package:muzzone/logic/blocs/bottom_navigation_bar/bottom_navigation_bar_state.dart';

class MainMenuButtons extends StatelessWidget {
  const MainMenuButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
        Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Column(
              children: [
                const Flexible(
                    flex: 6, fit: FlexFit.tight, child: SizedBox.shrink()),
                Flexible(
                  flex: 88,
                  fit: FlexFit.tight,
                  child: BlocBuilder<BottomNavigationBarBloc,
                      BottomNavigationBarState>(builder: (context, state) {
                    return ElevatedButton(
                      style: ButtonStyle(
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.r),
                        )),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.all(availableHeight / 200)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        overlayColor:
                            MaterialStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.grey.withOpacity(0.1);
                          }
                          return null;
                        }),
                      ),
                      onPressed: () {
                        BlocProvider.of<BottomNavigationBarBloc>(context)
                            .state
                            .tabController
                            ?.animateTo(0);
                        BlocProvider.of<BottomNavigationBarBloc>(context)
                            .add(SelectedBottomNavBarItem(index: 0));
                      },
                      child: Column(
                        children: [
                          Flexible(
                              flex: 6,
                              fit: FlexFit.tight,
                              child: SvgPicture.asset(
                                'assets/icons/main.svg',
                                width: availableHeight / 20,
                                height: availableHeight / 20,
                                color: state.index == 0
                                    ? AppColors.primaryColor
                                    : null,
                              )),
                          Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child:
                                  Text(LocaleKeys.main_name_first_screen.tr(),
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: state.index == 0
                                            ? AppColors.primaryColor
                                            : AppColors.greyColor,
                                      )))
                        ],
                      ),
                    );
                  }),
                ),
                const Flexible(
                    flex: 6, fit: FlexFit.tight, child: SizedBox.shrink()),
              ],
            )),
        const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
        Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Column(
              children: [
                const Flexible(
                    flex: 6, fit: FlexFit.tight, child: SizedBox.shrink()),
                Flexible(
                  flex: 88,
                  fit: FlexFit.tight,
                  child: BlocBuilder<BottomNavigationBarBloc,
                      BottomNavigationBarState>(builder: (context, state) {
                    return ElevatedButton(
                      style: ButtonStyle(
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.r),
                        )),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.all(availableHeight / 200)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        overlayColor:
                            MaterialStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.grey.withOpacity(0.1);
                          }
                          return null;
                        }),
                      ),
                      onPressed: () {
                        BlocProvider.of<BottomNavigationBarBloc>(context)
                            .state
                            .tabController
                            ?.animateTo(1);
                        BlocProvider.of<BottomNavigationBarBloc>(context)
                            .add(SelectedBottomNavBarItem(index: 1));
                      },
                      child: Column(
                        children: [
                          Flexible(
                              flex: 6,
                              fit: FlexFit.tight,
                              child: SvgPicture.asset(
                                'assets/icons/search.svg',
                                width: availableHeight / 20,
                                height: availableHeight / 20,
                                color: state.index == 1
                                    ? AppColors.primaryColor
                                    : null,
                              )),
                          Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child:
                                  Text(LocaleKeys.main_name_second_screen.tr(),
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: state.index == 1
                                            ? AppColors.primaryColor
                                            : AppColors.greyColor,
                                      )))
                        ],
                      ),
                    );
                  }),
                ),
                const Flexible(
                    flex: 6, fit: FlexFit.tight, child: SizedBox.shrink()),
              ],
            )),
        const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
        Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Column(
              children: [
                const Flexible(
                    flex: 6, fit: FlexFit.tight, child: SizedBox.shrink()),
                Flexible(
                  flex: 88,
                  fit: FlexFit.tight,
                  child: BlocBuilder<BottomNavigationBarBloc,
                      BottomNavigationBarState>(builder: (context, state) {
                    return ElevatedButton(
                      style: ButtonStyle(
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.r),
                        )),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.all(availableHeight / 200)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        overlayColor:
                            MaterialStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.grey.withOpacity(0.1);
                          }
                          return null;
                        }),
                      ),
                      onPressed: () {
                        BlocProvider.of<BottomNavigationBarBloc>(context)
                            .state
                            .tabController
                            ?.animateTo(2);
                        BlocProvider.of<BottomNavigationBarBloc>(context)
                            .add(SelectedBottomNavBarItem(index: 2));
                      },
                      child: Column(
                        children: [
                          Flexible(
                              flex: 6,
                              fit: FlexFit.tight,
                              child: SvgPicture.asset(
                                'assets/icons/my_music.svg',
                                width: availableHeight / 20,
                                height: availableHeight / 20,
                                color: state.index == 2
                                    ? AppColors.primaryColor
                                    : null,
                              )),
                          Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: Text(
                                  LocaleKeys.main_name_third_screen.tr(),
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color: state.index == 2
                                          ? AppColors.primaryColor
                                          : AppColors.greyColor)))
                        ],
                      ),
                    );
                  }),
                ),
                const Flexible(
                    flex: 6, fit: FlexFit.tight, child: SizedBox.shrink()),
              ],
            )),
        const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
      ],
    );
  }
}
