import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/ui/pages/profile/setting_profile/blocs/track_history_bloc.dart';
import 'package:muzzone/ui/pages/profile/setting_profile/widgets/choose_theme_app.dart';
import 'package:muzzone/ui/pages/profile/setting_profile/widgets/language_setting.dart';
import 'package:muzzone/ui/pages/profile/setting_profile/widgets/name_phone_photo.dart';
import 'package:muzzone/ui/widgets/layout_widgets/header_title.dart';

import '../../../../../generated/locale_keys.g.dart';
import '../blocs/support_bloc.dart';
import '../edit_profile_page/view/edit_profile_page.dart';

class SettingProfilePage extends StatelessWidget {
  static const id = 'SettingProfilePage';

  const SettingProfilePage({Key? key}) : super(key: key);

  Future<bool> _closeDropButtonsAndPop(BuildContext context, willPopScore) {
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
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        HeaderTitle(
                          onPress: () => _closeDropButtonsAndPop(context, false),
                          title: LocaleKeys.profile_setting.tr(),
                          icon: 'setting',
                          iconPress: () =>
                              Navigator.of(context).pushNamed(EditProfilePage.id),
                        ),
                        const NamePhonePhoto(),
                        const SettingProfileMyDivider(),
                        const ChooseThemeApp(),
                        const SettingProfileMyDivider(),
                        const LanguageSetting(),
                        const SettingProfileMyDivider(),
                        //const PrivacySupportProfileExit(),
                      ],
                    )
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
