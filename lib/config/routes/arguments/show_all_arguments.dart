import 'package:flutter/foundation.dart';

class ShowAllPageArguments {
  final dynamic item;
  final int id;
  final String title;
  final String fromPage;
  final VoidCallback? onPress;

  ShowAllPageArguments(
      {this.item,
      this.id = -1,
      required this.title,
      required this.fromPage,
      this.onPress,});
}
