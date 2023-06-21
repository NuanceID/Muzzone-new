import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/ui/pages/profile/setting_profile/edit_profile_page/widgets/edition_zone/edit_photo/bloc/edit_photo_bloc.dart';
import 'package:muzzone/ui/pages/profile/setting_profile/edit_profile_page/widgets/edition_zone/edit_photo/edit_photo.dart';
import 'package:muzzone/ui/pages/profile/setting_profile/edit_profile_page/widgets/edition_zone/name_phone_fields.dart';
import 'package:muzzone/ui/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../generated/locale_keys.g.dart';
import '../../../../../../logic/functions/dismiss_keyboard.dart';
import '../../../bloc/profile_bloc.dart';

class EditProfilePage extends StatelessWidget {
  static const id = 'EditProfilePage';

  EditProfilePage({Key? key}) : super(key: key);

  final profileBloc = GetIt.I.get<ProfileBloc>();
  final editPhotoBloc = GetIt.I.get<EditPhotoBloc>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        profileBloc.add(CancelEdition());
        editPhotoBloc.add(CancelPhotoEdition());
        return Future.value(true);
      },
      child: GestureDetector(
        onTap: () {
          profileBloc.add(ProfileCompleteEditionEvent());
          dismissKeyboard(context);
        },
        child: KeyboardDismissOnTap(
          child: PageLayout(
              child: Column(
            children: [
              HeaderTitle(
                title: LocaleKeys.edition.tr(),
                onPress: () {
                  profileBloc.add(CancelEdition());
                  editPhotoBloc.add(CancelPhotoEdition());
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: 4.5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MyPadding.horizontalPadding),
                child: Row(
                  children: [
                    const EditPhoto(),
                    SizedBox(
                      width: 3.w,
                    ),
                    NamePhoneFields(),
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              PrimaryButton(
                onPress: () {
                  profileBloc.add(SaveEdition());
                  editPhotoBloc.add(SavePhotoEdition());
                  Navigator.pop(context);
                },
                color: AppColors.primaryColor,
                text: LocaleKeys.save.tr(),
              ),
              PrimaryButton(
                onPress: () {
                  profileBloc.add(CancelEdition());
                  editPhotoBloc.add(CancelPhotoEdition());
                  Navigator.of(context).pop();
                },
                color: Theme.of(context).scaffoldBackgroundColor,
                text: LocaleKeys.cancel.tr(),
                textColor: Theme.of(context).splashColor,
                needBorder: true,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
