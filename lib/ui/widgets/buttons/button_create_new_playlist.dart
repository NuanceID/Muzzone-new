import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muzzone/config/config.dart';

import '../../../generated/locale_keys.g.dart';

class ButtonCreateNewPlaylist extends StatelessWidget {
  const ButtonCreateNewPlaylist({Key? key, required this.onPress})
      : super(key: key);

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5.r),
      onTap: onPress,
      child: Row(
        children: [
          const Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox.shrink()),
          Flexible(
              flex: 60,
              fit: FlexFit.tight,
              child: AutoSizeText(
                LocaleKeys.create_playlist.tr(),
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 14.sp,
                ),
                maxLines: 1,
                textAlign: TextAlign.center,
              )),
          const Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox.shrink()),
          Flexible(
              flex: 12,
              fit: FlexFit.tight,
              child: Icon(
                Icons.add,
                color: Theme.of(context).cardColor,
              )),
          const Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox.shrink()),
        ],
      ),
    );
  }
}
