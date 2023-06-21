import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/generated/locale_keys.g.dart';
import 'package:muzzone/ui/widgets/common_widgets/name_phone_text_form_field.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../logic/functions/dismiss_keyboard.dart';
import '../../../../bloc/profile_bloc.dart';

class NamePhoneFields extends StatelessWidget {
  NamePhoneFields({
    Key? key,
  }) : super(key: key);

  final profileBloc = GetIt.I.get<ProfileBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KeyboardVisibilityBuilder(builder: (context, visible) {
              return Text(
                LocaleKeys.name_lastname.tr(),
                style: TextStyle(
                  color: visible && state.activeNameField!
                      ? AppColors.primaryColor
                      : AppColors.greyColor,
                  fontSize: 13.sp,
                ),
              );
            }),
            SizedBox(
              height: 1.h,
            ),
            NamePhoneTextFormField(
              borderColor: AppColors.primaryColor,
              controller: state.nameController,
              onTap: () {
                profileBloc.add(ProfileEditUsernameFieldEvent());
              },
              textInputType: TextInputType.text,
              onEditingComplete: () {
                dismissKeyboard(context);
                profileBloc
                    .add(SetTempName(tempName: state.nameController.text));
              },
              onChanged: (value) {
                profileBloc.add(SetTempName(tempName: value));
              },
            ),
            SizedBox(
              height: 2.h,
            ),
            KeyboardVisibilityBuilder(
              builder: (context, visible) {
                return Text(
                  LocaleKeys.phone.tr(),
                  style: TextStyle(
                    color: visible && state.activePhoneField!
                        ? AppColors.primaryColor
                        : AppColors.greyColor,
                    fontSize: 13.sp,
                  ),
                );
              },
            ),
            SizedBox(
              height: 1.h,
            ),
            NamePhoneTextFormField(
              borderColor: AppColors.greyColor,
              controller: state.phoneController,
              onTap: () {
                profileBloc.add(
                  ProfileEditPhoneFieldEvent(),
                );
              },
              textInputType: TextInputType.phone,
              onEditingComplete: () => dismissKeyboard(context),
              onChanged: (value) {
                profileBloc.add(SetTempName(tempName: value));
              },
            ),
          ],
        );
      },
    );
  }
}
