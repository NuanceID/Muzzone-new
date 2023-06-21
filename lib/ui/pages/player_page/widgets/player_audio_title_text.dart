import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PlayerAudioTitleText extends StatelessWidget {
  const PlayerAudioTitleText({
    Key? key,
    required this.myAudio,
  }) : super(key: key);

  final Audio myAudio;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 3.5.h,
      child: Text(
        myAudio.metas.title!,
        style: TextStyle(
          fontSize: 3.h,
        ),
      ),
    );
  }
}
