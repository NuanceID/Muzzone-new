import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/data/local_data_store/local_data_store.dart';

import '../../../../../generated/locale_keys.g.dart';

class EmailRegisterDate extends StatefulWidget {
  const EmailRegisterDate({Key? key}) : super(key: key);

  @override
  State<EmailRegisterDate> createState() => _EmailRegisterDateState();
}

class _EmailRegisterDateState extends State<EmailRegisterDate> {
  final LocalDataStore _store = LocalDataStore();
  final String phone = '+79819667079';
  final String email = 'deniszavrin@gmail.com';
  late DateTime registerDate;

  @override
  void initState() {
    registerDate = DateTime.parse(_store.getRegisterDate());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileTile(
          title: LocaleKeys.e_mail.tr(),
          subtitle: email,
          readOnly: false,
          textInputType: TextInputType.emailAddress,
        ),
        ProfileTile(
          title: LocaleKeys.registration_data.tr(),
          subtitle:
              '${registerDate.day}.${registerDate.month.toString().padLeft(2, '0')}.${registerDate.year.toString().padLeft(2, '0')}',
          readOnly: true,
        )
      ],
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.readOnly,
      this.textInputType})
      : super(key: key);

  final String title;
  final String subtitle;
  final bool readOnly;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w),
      child: TextFormField(
        maxLines: 1,
        initialValue: subtitle,
        keyboardType: textInputType,
        readOnly: readOnly,
        decoration: InputDecoration(
          focusColor: Theme.of(context).secondaryHeaderColor,
          labelStyle: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(fontSize: 16.sp, color: AppColors.greyColor),
          labelText: title,
          border: InputBorder.none,
          suffixIcon: SvgPicture.asset(
            '${iconsPath}arrow.svg',
          ),
          suffixIconConstraints: BoxConstraints(
            maxHeight: 3.h,
            maxWidth: 8.sp,
          ),
        ),
      ),
    );
  }
}
