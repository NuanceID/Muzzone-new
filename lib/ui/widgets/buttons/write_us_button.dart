import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:muzzone/config/config.dart';
import 'package:sizer/sizer.dart';

import '../../../generated/locale_keys.g.dart';

class WriteUsButton extends StatelessWidget {
  const WriteUsButton({Key? key, required this.onPress}) : super(key: key);

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: MyPadding.horizontalPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 1,
            color: AppColors.primaryColor,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3.h),
            child: Text(
              LocaleKeys.write_us.tr(),
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
