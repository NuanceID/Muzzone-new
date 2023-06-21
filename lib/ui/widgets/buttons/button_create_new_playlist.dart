import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:muzzone/config/config.dart';
import 'package:sizer/sizer.dart';

import '../../../generated/locale_keys.g.dart';

class ButtonCreateNewPlaylist extends StatelessWidget {
  const ButtonCreateNewPlaylist({Key? key, required this.onPress})
      : super(key: key);

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Row(
        children: [
          Text(
            LocaleKeys.create_playlist.tr(),
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 13.sp,
            ),
          ),
          Icon(
            Icons.add,
            color: Theme.of(context).cardColor,
          ),
        ],
      ),
    );
  }
}
