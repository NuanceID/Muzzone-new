import 'package:flutter/material.dart';
import 'package:muzzone/config/config.dart';

class ThreeDotsButton extends StatelessWidget {
  const ThreeDotsButton({Key? key, required this.audio, required this.fromPage})
      : super(key: key);

  final dynamic audio;
  final String fromPage;

  @override
  Widget build(BuildContext context) {
    return Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () {
            //threeDotsFunction(context, audio, fromPage)
          },
          child: const Icon(
            Icons.more_vert,
            color: AppColors.primaryColor,
            fill: 0.8,
          ),
        ));
  }
}
