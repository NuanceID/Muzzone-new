import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/config.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../widgets/widgets.dart';
import '../../bloc/profile_bloc.dart';

class NamePhonePhoto extends StatelessWidget {
  const NamePhonePhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 7.w,
        right: 7.w,
        top: 2.h,
      ),
      child: Row(
        children: [
          const ImageWidget(
            icon: Icons.no_photography_outlined,
            needFunction: false,
          ),
          SizedBox(
            width: 5.w,
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.5.h,
                  ),
                  Text(
                    LocaleKeys.name_lastname.tr(),
                    style:
                        TextStyle(fontSize: 12.sp, color: AppColors.greyColor),
                  ),
                  Text(
                    state.name,
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    LocaleKeys.phone.tr(),
                    style:
                        TextStyle(fontSize: 12.sp, color: AppColors.greyColor),
                  ),
                  Text(
                    state.phoneNumber,
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    LocaleKeys.registration_data.tr(),
                    style:
                        TextStyle(fontSize: 12.sp, color: AppColors.greyColor),
                  ),
                  Text(
                    '${state.registerDate.day}.${state.registerDate.month.toString().padLeft(2, '0')}.${state.registerDate.year.toString().padLeft(2, '0')}',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
