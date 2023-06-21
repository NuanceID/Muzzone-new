import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muzzone/config/path/path.dart';
import 'package:sizer/sizer.dart';

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
  final bool? needIconBack;
  final bool? needRotate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.h,
      padding: EdgeInsets.only(top: paddingTop ?? 5.h, right: 5.w, left: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onPress ??
                () async {
                  if (needIconBack!) Navigator.pop(context);
                },
            child: Container(
              height: 40.sp,
              width: 40.sp,
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              color: Colors.redAccent.withOpacity(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.rotate(
                    angle: needRotate! ? -pi / 2 : 0,
                    child: SvgPicture.asset('${iconsPath}back.svg',
                        width: 20.sp,
                        height: 20.sp,
                        fit: BoxFit.none,
                        color: needIconBack!
                            ? Theme.of(context).secondaryHeaderColor
                            : Colors.white.withOpacity(0)),
                  ),
                ],
              ),
            ),
          ),
          if (title != null)
            Text(
              title!,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          GestureDetector(
            onTap: iconPress ?? () {},
            child: Container(
              height: 40.sp,
              width: 40.sp,
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              color: Colors.redAccent.withOpacity(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (icon == 'tree_dots')
                    Transform.rotate(
                      angle: pi / 2,
                      child: Icon(
                        size: 15.sp,
                        Icons.more_horiz,
                        color: Theme.of(context).cardColor,
                        fill: 0.8,
                      ),
                    )
                  else
                    SvgPicture.asset(
                      fit: BoxFit.none,
                      icon != null
                          ? '$iconsPath$icon.svg'
                          : '${iconsPath}back.svg',
                      color: iconColor == null && icon == null
                          ? Colors.white.withOpacity(0)
                          : iconColor ?? Theme.of(context).splashColor,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
