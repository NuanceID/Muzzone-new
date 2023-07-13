import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFontFamily {
  static String alumna = 'Alumna';
  static String nunitoSans = 'NunitoSans';
}

class AppColors {
  static const Color primaryColor = Color(0xff3D6394);
  static const Color disabledTipOnBoard = Color(0xffEBEBEB);
  static const Color greyColor = Color(0xff90959B);
  static const Color greyBackgroundColor = Color(0xff323232);
  static const Color testGrey = Color(0xFF9EB4CF);
}

class AppGradient {
  static List<Color> linearGoldGradient = [
    const Color(0xffF4C774),
    const Color(0xffA0713F),
    const Color(0xffDFB469),
    const Color(0xffF8F4B5),
    const Color(0xffDFB469),
    const Color(0xff6D4424)
  ];

  static Shader linearGoldGradientShade = const LinearGradient(
    colors: <Color>[
      Color(0xffF4C774),
      Color(0xffA0713F),
      Color(0xffDFB469),
      Color(0xffF8F4B5),
      Color(0xffDFB469),
      Color(0xff6D4424)
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  static LinearGradient secondLinearGoldGradient = const LinearGradient(
    colors: <Color>[
      Color(0xffF4C774),
      Color(0xffA0713F),
      Color(0xffDFB469),
      Color(0xffF8F4B5),
      Color(0xffDFB469),
      Color(0xff6D4424)
    ],
  );
  static LinearGradient gradualFadeText = LinearGradient(
    colors: <Color>[
      const Color(0xffFFFFFF),
      const Color(0xffFFFFFF).withAlpha(0),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class Space {
  static double bottomBarHeight = 18.1.h;
}

class MyPadding {
  static double horizontalPadding = 17.w;
}

class StatusBarStyle {
  static SystemUiOverlayStyle dark = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  );

  static SystemUiOverlayStyle light = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );
}
