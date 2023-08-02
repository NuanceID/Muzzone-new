import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/data/local_data_store/local_data_store.dart';
import 'package:muzzone/generated/locale_keys.g.dart';
import 'package:muzzone/ui/widgets/widgets.dart';

import '../../../../logic/blocs/on_boarding/on_board_bloc.dart';
import '../../main_page/view/main_page.dart';
import 'first_onboard.dart';
import 'second_onboard.dart';
import 'third_onboard.dart';

class OnBoardingPage extends StatefulWidget {
  static const id = 'OnBoardingPage';

  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  late OnBoardBloc onboardBloc;

  final PageController _pageController = PageController(initialPage: 0);
  final LocalDataStore _store = LocalDataStore();

  Future<void> _onPageChanged(index) async {
    if (index == 0) {
      onboardBloc.add(OnboardChangeEvent(
          currentPage: index, buttonName: LocaleKeys.button_start.tr()));
    } else {
      onboardBloc.add(OnboardChangeEvent(
          currentPage: index, buttonName: LocaleKeys.button_next.tr()));
    }
  }

  void _nextPage(int currentPage) {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
    if (currentPage == 2) {
      _store.setNeedOnboard(false);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(MainPage.id, (route) => false);
    }
  }

  void _previousPage() {
    _pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    onboardBloc = context.read<OnBoardBloc>();

    return Scaffold(
      body: SafeArea(
        top: true,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return false;
              },
              child: PageView.builder(
                  itemCount: 3,
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (ctx, i) => OnBoard(
                        index: i,
                        onPress: _previousPage,
                      )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BlocBuilder<OnBoardBloc, OnBoardState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 3; i++)
                            if (i == state.currentPage)
                              const AnimatedController(
                                isActive: true,
                                colorEnable: AppColors.primaryColor,
                                colorDisable: AppColors.disabledTipOnBoard,
                              )
                            else
                              const AnimatedController(
                                isActive: false,
                                colorEnable: AppColors.primaryColor,
                                colorDisable: AppColors.disabledTipOnBoard,
                              )
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 4.5.h,
                  ),
                  BlocBuilder<OnBoardBloc, OnBoardState>(
                    builder: (context, state) {
                      return PrimaryButton(
                        onPress: () {
                          _nextPage(state.currentPage);
                        },
                        color: AppColors.primaryColor,
                        text: state.currentPage != 0
                            ? LocaleKeys.button_next.tr()
                            : LocaleKeys.button_start.tr(),
                      );
                    },
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key, required this.index, this.onPress})
      : super(key: key);

  final int index;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const FirstOnboard();
      case 1:
        return SecondOnBoard(onPress: onPress!);

      default:
        return ThirdOnBoard(
          onPress: onPress!,
        );
    }
  }
}
