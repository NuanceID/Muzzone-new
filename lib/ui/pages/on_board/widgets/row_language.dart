import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/config.dart';

class RowLanguage extends StatelessWidget {
  const RowLanguage(
      {Key? key,
      required this.locale,
      required this.asset,
      required this.countryName})
      : super(key: key);

  final String locale;
  final String asset;
  final String countryName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.setLocale(Locale(locale));
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 7.w),
      title: Text(
        countryName,
        style: TextStyle(
            fontWeight:
                context.locale.toString() == locale ? FontWeight.bold : null),
      ),
      leading: Image(
        image: AssetImage(asset),
      ),
      trailing: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            100,
          ),
          color: context.locale.toString() == locale
              ? AppColors.primaryColor
              : AppColors.disabledTipOnBoard,
        ),
      ),
    );
  }
}
