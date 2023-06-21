import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/ui/pages/profile/setting_profile/widgets/privacy_policy_page.dart';
import 'package:sizer/sizer.dart';

import '../../../../../generated/locale_keys.g.dart';
import '../../../../../logic/blocs/bottom_bar/bottom_bar_bloc.dart';
import '../../../../widgets/widgets.dart';
import '../../../player_page/bloc/audio_bloc.dart';
import '../../../splash_page.dart';
import '../blocs/support_bloc.dart';
import '../blocs/track_history_bloc.dart';

class PrivacySupportProfileExit extends StatefulWidget {
  const PrivacySupportProfileExit({Key? key}) : super(key: key);

  @override
  State<PrivacySupportProfileExit> createState() =>
      _PrivacySupportProfileExitState();
}

class _PrivacySupportProfileExitState extends State<PrivacySupportProfileExit> {
  final trackHistoryBloc = GetIt.I.get<TrackHistoryBloc>();

  final supportBloc = GetIt.I.get<SupportBloc>();
  final bottomBarBloc = GetIt.I.get<BottomBarBloc>();
  final audioBloc = GetIt.I.get<AudioBloc>();

  final List<Map> myHistoryList = List.generate(
      5,
      (index) => {
            "id": index,
            "name": "History track $index",
            "background_image": "0"
          });

  Future<void> firstAsyncFunction() async {
    // выполнение первой асинхронной функции
    await FirebasePhoneAuthHandler.signOut(context);
  }

  Future<void> secondAsyncFunction() async {
    await firstAsyncFunction(); // ожидание выполнения первой функции
    // выполнение второй асинхронной функции
    audioBloc.add(CloseAllForExitProfile());
    await Navigator.of(context)
        .pushNamedAndRemoveUntil(SplashPage.id, (route) => false);
    con.player.stop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackHistoryBloc, TrackHistoryState>(
      builder: (context, state) {
        return BlocBuilder<SupportBloc, SupportState>(
          builder: (context, supportState) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: Column(
                children: [
                  HistorySupportTile(
                    onPress: () {
                      Navigator.of(context).pushNamed(PrivacyPolicyPage.id);
                    },
                    trailingIcon: '${iconsPath}arrow.svg',
                    color: AppColors.primaryColor,
                    title: LocaleKeys.privacy_policy.tr(),
                    leadingIcon: '${iconsPath}privacy.svg',
                  ),
                  HistorySupportTile(
                      onPress: () {
                        if (supportState.isOpen) {
                          supportBloc.add(CloseSupportEvent());
                        } else {
                          supportBloc.add(OpenSupportEvent());
                        }
                      },
                      trailingIcon: supportState.isOpen
                          ? '${iconsPath}arrow_up.svg'
                          : '${iconsPath}arrow_down.svg',
                      color: AppColors.primaryColor,
                      title: LocaleKeys.customer_service.tr(),
                      leadingIcon: '${iconsPath}support.svg'),
                  if (supportState.isOpen)
                    WriteUsButton(
                      onPress: () {},
                    ),
                  SizedBox(
                    height: 1.h,
                  ),
                  HistorySupportTile(
                    color: Theme.of(context).secondaryHeaderColor,
                    title: LocaleKeys.profile_exit.tr(),
                    leadingIcon: '${iconsPath}profile_exit.svg',
                    onPress: () {
                      showDialog(
                          context: context,
                          builder: (context) => Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 90.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          8,
                                        ),
                                        color: Theme.of(context)
                                            .dialogBackgroundColor,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            LocaleKeys.confirm_profile_exit
                                                .tr(),
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .secondaryHeaderColor),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          _buildButtonDialog(
                                            LocaleKeys.exit.tr(),
                                            () async {
                                              await secondAsyncFunction();
                                            },
                                            true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        height: 7.h,
                                        width: 90.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Theme.of(context)
                                              .dialogBackgroundColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            LocaleKeys.cancel.tr(),
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).splashColor,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                    },
                    trailingIcon: '${iconsPath}arrow.svg',
                    iconColor: Theme.of(context).secondaryHeaderColor,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildButtonDialog(text, onPress, isButtonConfirm) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        height: 6.h,
        decoration: BoxDecoration(
          color: isButtonConfirm ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                color: isButtonConfirm ? Colors.white : AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HistorySupportTile extends StatelessWidget {
  const HistorySupportTile({
    Key? key,
    required this.title,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.color,
    required this.onPress,
    this.iconColor,
  }) : super(key: key);

  final String title;
  final String leadingIcon;
  final String trailingIcon;
  final Color color;
  final VoidCallback onPress;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      focusColor: Theme.of(context).scaffoldBackgroundColor,
      style: ListTileStyle.list,
      hoverColor: Theme.of(context).scaffoldBackgroundColor,
      selectedColor: Theme.of(context).scaffoldBackgroundColor,
      enableFeedback: false,
      onTap: onPress,
      textColor: color,
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
      dense: true,
      title: Text(
        title,
        style: TextStyle(fontSize: 12.sp),
        textAlign: TextAlign.start,
      ),
      leading: SvgPicture.asset(
        leadingIcon,
        color: iconColor == null ? null : color,
      ),
      trailing: SvgPicture.asset(
        trailingIcon,
        color: iconColor == null ? null : color,
      ),
    );
  }
}
