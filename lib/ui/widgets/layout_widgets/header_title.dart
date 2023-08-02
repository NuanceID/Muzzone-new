import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzone/config/constants/constants.dart';
import 'package:muzzone/config/path/path.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({
    Key? key,
    this.title,
    this.onPress,
    this.icon,
    this.iconPress,
    this.paddingTop,
    this.iconColor,
    this.needIconBack = true,
    this.needRotate = false,
  }) : super(key: key);

  final String? title;
  final VoidCallback? onPress;
  final String? icon;
  final VoidCallback? iconPress;
  final double? paddingTop;
  final Color? iconColor;
  final bool needIconBack;
  final bool? needRotate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: availableHeight / 10,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          children: [
            const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
            Flexible(
              flex: 8,
              fit: FlexFit.tight,
              child: Center(
                child: Material(
                    color: Colors.transparent,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: needIconBack
                          ? onPress ??
                              () {
                                Navigator.pop(context);
                              }
                          : null,
                      child: Ink(
                          padding: EdgeInsets.all(availableHeight / 60),
                          child: Transform.rotate(
                            angle: needRotate! ? -pi / 2 : 0,
                            child: SvgPicture.asset('${iconsPath}back.svg',
                                width: availableHeight / 40,
                                height: availableHeight / 40,
                                color: needIconBack
                                    ? Theme.of(context).secondaryHeaderColor
                                    : Colors.white.withOpacity(0)),
                          )),
                    )),
              ),
            ),
            if (title != null) ...[
              Flexible(
                  flex: 36,
                  fit: FlexFit.tight,
                  child: Text(
                    title!,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
            ],
            const Flexible(
                flex: 9, fit: FlexFit.tight, child: SizedBox.shrink())
          ],
        )
      ]),
    );
  }
}
