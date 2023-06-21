import 'package:flutter/material.dart';
import 'package:muzzone/config/config.dart';
import 'package:sizer/sizer.dart';

class FirstOnboard extends StatelessWidget {
  const FirstOnboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Container(
          height: 50.h,
          width: 80.w,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                '${imagesOnBoardPath}on_board.png',
              ),
              fit: BoxFit.scaleDown,
            ),
          ),
          child: Center(
            child: Image(
              image: const AssetImage(
                '${imagesOnBoardPath}logo.png',
              ),
              fit: BoxFit.scaleDown,
              width: 25.w,
              height: 30.h,
            ),
          ),
        ),
        Center(
          child: Text(
            constantMuzzone,
            style: TextStyle(
              fontFamily: AppFontFamily.alumna,
              fontSize: 25.sp,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 4,
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}
