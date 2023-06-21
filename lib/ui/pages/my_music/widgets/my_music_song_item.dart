import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/ui/controllers/controllers.dart';
import 'package:muzzone/ui/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../player_page/bloc/audio_bloc.dart';

class MyMusicSongsItem extends StatelessWidget {
  MyMusicSongsItem({
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

  final con = GetIt.I.get<MainController>();
  final audioBloc = GetIt.I.get<AudioBloc>();

  @override
  Widget build(BuildContext context) {
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
              height: 10.h,
              onPress: () {
                con.playSong(audios!, i);
                audioBloc.add(StartPlaying(audios!));
              },
            )
        else
          for (var i = 0; i < 3; i++)
            AudioRow(
              audio: audios![i],
              height: 10.h,
              onPress: () {
                con.playSong(audios!, i);
                audioBloc.add(StartPlaying(audios!));
              },
            ),
      ],
    );
  }
}
