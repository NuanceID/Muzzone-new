import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzone/config/config.dart';

import '../../../generated/locale_keys.g.dart';

class ButtonCreateNewPlaylist extends StatelessWidget {
  const ButtonCreateNewPlaylist({Key? key, required this.onPress})
      : super(key: key);

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(5.r),
          onTap: onPress,
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Row(
              children: [
                const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
                Flexible(
                    flex: 24,
                    fit: FlexFit.tight,
                    child: SizedBox(
                        height: availableHeight / 22,
                        child: Align(
                          alignment: const Alignment(1, 0),
                          child: AutoSizeText(
                            LocaleKeys.create_playlist.tr(),
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: Theme.of(context).cardColor),
                            maxLines: 1,
                            textAlign: TextAlign.end,
                          ),
                        ))),
                const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
                Flexible(
                    flex: 4,
                    fit: FlexFit.tight,
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).cardColor,
                    )),
                const Flexible(
                    flex: 1, fit: FlexFit.tight, child: SizedBox.shrink()),
              ],
            ),
          ),
        ));
  }
}
