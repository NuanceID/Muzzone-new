import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muzzone/config/config.dart';

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
    return Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(5.r),
          onTap: onPress,
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Row(
              children: [
                const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
                Flexible(
                    flex: 12,
                    fit: FlexFit.tight,
                    child: SizedBox(
                        height: availableHeight / 22,
                        child: Center(
                            child: AutoSizeText(
                          LocaleKeys.show_all.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 14.sp),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        )))),
                const Flexible(fit: FlexFit.tight, child: SizedBox.shrink())
              ],
            ),
          ),
        ));
  }
}
