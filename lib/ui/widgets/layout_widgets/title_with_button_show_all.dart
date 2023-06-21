import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:muzzone/generated/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config.dart';
import '../buttons/button_create_new_playlist.dart';
import '../buttons/button_show_all.dart';

class TitleWithButtonShowAll extends StatelessWidget {
  const TitleWithButtonShowAll({
    Key? key,
    required this.title,
    required this.item,
    this.isPlaylists = false,
    this.createNewPlaylist,
    required this.fromPage,
    required this.onPress,
  }) : super(key: key);

  final String title;
  final dynamic item;
  final bool? isPlaylists;
  final VoidCallback? createNewPlaylist;
  final String fromPage;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MyPadding.horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          if (title == LocaleKeys.language_affiliation.tr())
            Container(
              height: 4.h,
            )
          else if (isPlaylists != null && isPlaylists == false)
            ButtonShowAll(
              fromPage: fromPage,
              item: item,
              title: title,
              onPress: onPress,
            )
          else
            ButtonCreateNewPlaylist(
              onPress: createNewPlaylist!,
            ),
        ],
      ),
    );
  }
}
