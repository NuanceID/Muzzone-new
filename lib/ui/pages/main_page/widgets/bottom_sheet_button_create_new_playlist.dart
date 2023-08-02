import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/generated/locale_keys.g.dart';

class BottomSheetButtonCreateNewPlaylist extends StatelessWidget {
  const BottomSheetButtonCreateNewPlaylist({Key? key, required this.onPress})
      : super(key: key);

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Row(
        children: [
          const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
          Flexible(
              flex: 24,
              fit: FlexFit.tight,
              child: AutoSizeText(
                LocaleKeys.create_playlist.tr(),
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Theme.of(context).cardColor),
                maxLines: 1,
                textAlign: TextAlign.center,
              )),
          const Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox.shrink()),
        ],
      ),
    );
  }
}
