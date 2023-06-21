import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:muzzone/config/config.dart';
import 'package:sizer/sizer.dart';

import '../../../generated/locale_keys.g.dart';

class ButtonShowAll extends StatelessWidget {
  const ButtonShowAll({
    Key? key,
    required this.item,
    required this.title,
    required this.fromPage,
    required this.onPress,
  }) : super(key: key);

  final dynamic item;
  final String title;
  final String fromPage;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            child: Text(
              LocaleKeys.show_all.tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 10.sp),
            ),
          ),
        ),
      ),
    );
  }
}
