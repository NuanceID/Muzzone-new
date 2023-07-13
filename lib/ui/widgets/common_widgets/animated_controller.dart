import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedController extends StatelessWidget {
  final bool isActive;
  final Color? colorEnable;
  final Color? colorDisable;

  const AnimatedController({
    super.key,
    required this.isActive,
    required this.colorEnable,
    required this.colorDisable,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 3500),
      margin: EdgeInsets.all(6.sp),
      height: 6,
      width: 40,
      decoration: BoxDecoration(
        color: isActive ? colorEnable : colorDisable,
        borderRadius: BorderRadius.all(Radius.circular(12.sp)),
      ),
      child: Container(),
    );
  }
}
