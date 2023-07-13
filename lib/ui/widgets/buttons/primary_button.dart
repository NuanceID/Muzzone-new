import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.onPress,
    required this.color,
    required this.text,
    this.textColor,
    this.needBorder = false,
  }) : super(key: key);

  final VoidCallback onPress;
  final Color color;
  final String text;
  final Color? textColor;
  final bool? needBorder;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 7.w, right: 7.w, bottom: 2.h),
        child: GestureDetector(
          onTap: onPress,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(
                15,
              ),
              border: needBorder!
                  ? Border.all(width: 2, color: Theme.of(context).splashColor)
                  : null,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.5.sp,
                    color: textColor ?? Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
