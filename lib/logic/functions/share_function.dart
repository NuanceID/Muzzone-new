import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';

void shareFunction(text, BuildContext context, needPop) {
  log('share - $text');
  if (needPop) {
    Navigator.of(context).pop();
  }
  Share.share(text);
}
