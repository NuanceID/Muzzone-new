import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muzzone/generated/locale_keys.g.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            child: Row(
          children: [
            const Flexible(
              fit: FlexFit.tight,
              child: SizedBox.shrink(),
            ),
            Flexible(
              flex: title == LocaleKeys.language_affiliation.tr() ? 12 : 9,
              fit: FlexFit.tight,
              child: AutoSizeText(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
              ),
            ),
            const Flexible(
              fit: FlexFit.tight,
              child: SizedBox.shrink(),
            ),
            if (title == LocaleKeys.language_affiliation.tr())
              const Flexible(child: SizedBox.shrink())
            else if (isPlaylists != null && isPlaylists == false)
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: ButtonShowAll(
                  fromPage: fromPage,
                  item: item,
                  title: title,
                  onPress: onPress,
                ),
              )
            else
              Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: ButtonCreateNewPlaylist(
                    onPress: createNewPlaylist!,
                  )),
            const Flexible(
              fit: FlexFit.tight,
              child: SizedBox.shrink(),
            ),
          ],
        )),
      ],
    );
  }
}
