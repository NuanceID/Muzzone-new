import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../config/utils/globals.dart';

void showSnackBar(
  String text, {
  Duration duration = const Duration(seconds: 2),
}) {
  Globals.scaffoldMessengerKey.currentState
    ?..clearSnackBars()
    ..showSnackBar(
      SnackBar(content: Text(text), duration: duration),
    );
}

void showFlutterToast(Color backgroundColor, Color textColor, String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 3,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 2.h,
  );
}

bool isNullOrBlank(String? data) => data?.trim().isEmpty ?? true;

void log(
  String screenId, {
  dynamic msg,
  dynamic error,
  StackTrace? stackTrace,
}) =>
    devtools.log(
      msg.toString(),
      error: error,
      name: screenId,
      stackTrace: stackTrace,
    );
