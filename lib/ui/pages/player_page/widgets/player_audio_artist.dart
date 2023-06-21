import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/config.dart';
import '../../../../data/data.dart';
import '../../artist/view/artist_page.dart';
import '../bloc/audio_bloc.dart';

class PlayerAudioArtist extends StatelessWidget {
  PlayerAudioArtist({
    Key? key,
    required this.myAudio,
  }) : super(key: key);

  final Audio myAudio;
  final audioBloc = GetIt.I.get<AudioBloc>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        for (var artist in ArtistsRepository.localArtists) {
          if (artist.name == myAudio.metas.artist) {
            audioBloc.add(ClosePlayerWithButton());
            Globals.kNavigatorKey.currentState?.pushNamed(ArtistPage.id,
                arguments: ArtistPageArguments(artist: artist));
          }
        }
      },
      child: SizedBox(
        height: 2.3.h,
        child: Text(
          myAudio.metas.artist!,
          style: TextStyle(color: Theme.of(context).cardColor, fontSize: 2.h),
        ),
      ),
    );
  }
}
