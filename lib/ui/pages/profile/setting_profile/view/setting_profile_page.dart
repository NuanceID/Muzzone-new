import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/ui/pages/profile/setting_profile/blocs/track_history_bloc.dart';
import 'package:muzzone/ui/pages/profile/setting_profile/widgets/choose_theme_app.dart';
import 'package:muzzone/ui/pages/profile/setting_profile/widgets/history_support_profile_exit.dart';
import 'package:muzzone/ui/pages/profile/setting_profile/widgets/language_setting.dart';
import 'package:muzzone/ui/pages/profile/setting_profile/widgets/name_phone_photo.dart';
import 'package:muzzone/ui/widgets/layout_widgets/header_title.dart';
import 'package:muzzone/ui/widgets/layout_widgets/page_layout.dart';
import 'package:sizer/sizer.dart';

import '../../../../../generated/locale_keys.g.dart';
import '../blocs/support_bloc.dart';
import '../edit_profile_page/view/edit_profile_page.dart';

class SettingProfilePage extends StatelessWidget {
  static const id = 'SettingProfilePage';

  SettingProfilePage({Key? key}) : super(key: key);

  final trackHistoryBloc = GetIt.I.get<TrackHistoryBloc>();
  final supportBloc = GetIt.I.get<SupportBloc>();

  Future<bool> _closeDropButtonsAndPop(BuildContext context, willPopScore) {
    trackHistoryBloc.add(CloseTrackHistoryEvent());
    supportBloc.add(CloseSupportEvent());
    if (willPopScore) {
      return Future.value(true);
    } else {
      Navigator.of(context).pop();
      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: BlocBuilder<TrackHistoryBloc, TrackHistoryState>(
        builder: (context, state) {
          return BlocBuilder<SupportBloc, SupportState>(
            builder: (context, supportState) {
              return WillPopScope(
                onWillPop: () => _closeDropButtonsAndPop(context, true),
                child: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: PageLayout(
                    children: [
                      HeaderTitle(
                        onPress: () => _closeDropButtonsAndPop(context, false),
                        title: LocaleKeys.profile_setting.tr(),
                        icon: 'setting',
                        iconPress: () =>
                            Navigator.of(context).pushNamed(EditProfilePage.id),
                      ),
                      NamePhonePhoto(),
                      SettingProfileMyDivider(),
                      ChooseThemeApp(),
                      SettingProfileMyDivider(),
                      LanguageSetting(),
                      SettingProfileMyDivider(),
                      PrivacySupportProfileExit(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SettingProfileMyDivider extends StatelessWidget {
  const SettingProfileMyDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MyPadding.horizontalPadding,
        vertical: 2.h,
      ),
      child: Container(
        width: double.infinity,
        height: 0.2.h,
        padding: EdgeInsets.symmetric(horizontal: MyPadding.horizontalPadding),
        color: AppColors.greyColor.withOpacity(0.6),
      ),
    );
  }
}
