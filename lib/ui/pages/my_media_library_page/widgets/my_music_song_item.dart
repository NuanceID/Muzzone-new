/*
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzzone/logic/blocs/audio/audio_event.dart';
import 'package:muzzone/ui/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../../logic/blocs/audio/audio_bloc.dart';

class MyMusicSongsItem extends StatelessWidget {
  const MyMusicSongsItem({
    Key? key,
    this.audios,
    required this.title,
    required this.fromPage,
    required this.onPressShowAll,
  }) : super(key: key);

  final List<Audio>? audios;
  final String title;
  final String fromPage;
  final Function() onPressShowAll;

  @override
  Widget build(BuildContext context) {
    final audioBloc = context.read<AudioBloc>();

    return Column(
      children: [
        SizedBox(
          height: 3.h,
        ),
        TitleWithButtonShowAll(
          fromPage: fromPage,
          title: title,
          item: audios,
          onPress: onPressShowAll,
        ),
        SizedBox(
          height: 2.h,
        ),
        if (audios!.length < 3)
          for (var i = 0; i < audios!.length; i++)
            AudioRow(
              audio: audios![i],
              onPress: () {
                con.playSong(audios!, i);
                audioBloc.add(Play(audios!));
              },
            )
        else
          for (var i = 0; i < 3; i++)
            AudioRow(
              audio: audios![i],
              onPress: () {
                con.playSong(audios!, i);
                audioBloc.add(Play(audios!));
              },
            ),
      ],
    );
  }
}
*/
