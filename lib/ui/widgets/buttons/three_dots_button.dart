import 'dart:math';

import 'package:flutter/material.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/logic/functions/three_dots_function.dart';
import 'package:sizer/sizer.dart';

class ThreeDotsButton extends StatelessWidget {
  const ThreeDotsButton({Key? key, required this.audio, required this.fromPage})
      : super(key: key);

  final dynamic audio;
  final String fromPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => threeDotsFunction(context, audio, fromPage),
      child: Container(
        height: 50.sp,
        width: 35.sp,
        color: Colors.red.withOpacity(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Transform.rotate(
              angle: pi / 2,
              child: Icon(
                size: 15.sp,
                Icons.more_horiz,
                color: AppColors.primaryColor,
                fill: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
