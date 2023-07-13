import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:muzzone/logic/blocs/audio/audio_event.dart';
import 'package:muzzone/ui/pages/player_page/widgets/player_bottom_position_seek.dart';

import '../../../config/config.dart';
import '../../controllers/controllers.dart';
import '../../../logic/blocs/audio/audio_bloc.dart';
import '../widgets.dart';

class BottomPlayerWidget extends StatelessWidget {
  const BottomPlayerWidget({Key? key, required this.onPress}) : super(key: key);

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<IcyMetadata?>(
        stream: BlocProvider.of<AudioBloc>(context).state.justAudioPlayer.icyMetadataStream,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () {
              BlocProvider.of<AudioBloc>(context).add(OpenSlidingPanel());
            },
            child: Container(
              height: availableHeight / 8,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.r),
                    topLeft: Radius.circular(20.r)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                      flex: 10,
                      fit: FlexFit.tight,
                      child: Row(
                        children: [
                          const Flexible(
                              fit: FlexFit.tight,
                              child: SizedBox.shrink()),
                          Flexible(
                            flex: 30,
                            fit: FlexFit.tight,
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 45,
                                  fit: FlexFit.tight,
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(3.r),
                                    child: CachedNetworkImage(
                                      imageUrl: ,
                                      width: availableHeight / 17,
                                      height: availableHeight / 17,
                                      progressIndicatorBuilder:
                                          (context, url, l) =>
                                      const LoadingImage(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: SizedBox.shrink()),
                                Flexible(
                                  flex: 220,
                                  fit: FlexFit.tight,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Flexible(
                                          fit: FlexFit.tight,
                                          child: SizedBox.shrink()),
                                      Flexible(
                                        flex: 10,
                                        child: Text(
                                          playing.audio.audio.metas.title ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.montserrat(
                                              fontWeight:
                                              FontWeight.w600,
                                              fontSize: 13.sp,
                                              color: Colors.black),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      const Flexible(
                                          fit: FlexFit.tight,
                                          child: SizedBox.shrink()),
                                      Flexible(
                                          flex: 10,
                                          child: Text(
                                            playing.audio.audio.metas.artist ?? '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp,
                                                color: AppColors.greyColor),
                                            textAlign: TextAlign.start,
                                          )),
                                      const Flexible(
                                          fit: FlexFit.tight,
                                          child: SizedBox.shrink()),
                                    ],
                                  ),
                                ),
                                const Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: SizedBox.shrink()),
                                Flexible(
                                  flex: 120,
                                  fit: FlexFit.tight,
                                  child: PlayerBuilder.isPlaying(
                                    player: BlocProvider.of<AudioBloc>(context).state.justAudioPlayer,
                                    builder: (context, isPlaying) {
                                      return BottomPlayingController(
                                        addToFavourite: () {
                                          /*BlocProvider.of<FavouriteAudiosBloc>(context).add(
                                          AddOrRemoveEvent(
                                              int.parse(BlocProvider.of<AudioBloc>(context).state.currentAudio?.metas.id ?? '',)));*/
                                        },
                                        isPlaylist: true,
                                        onPlay: () {
                                          BlocProvider.of<AudioBloc>(context).state.justAudioPlayer.playOrPause();
                                        },
                                        isPlaying: isPlaying,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Flexible(
                              fit: FlexFit.tight,
                              child: SizedBox.shrink()),
                        ],
                      )),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Row(
                      children: [
                        const Flexible(
                            fit: FlexFit.tight,
                            child: SizedBox.shrink()),
                        Flexible(
                            flex: 30,
                            fit: FlexFit.tight,
                            child:
                            _buildPlayerBottomPositionSeek(context)),
                        const Flexible(
                            fit: FlexFit.tight,
                            child: SizedBox.shrink()),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });



  }

  PlayerBuilder _buildPlayerBottomPositionSeek(BuildContext context) {
    return BlocProvider.of<AudioBloc>(context).state.justAudioPlayer.builderRealtimePlayingInfos(
        builder: (context, RealtimePlayingInfos? infos) {
          if (infos == null) {
            return Container();
          }

          return PlayerBottomPositionSeek(
            currentPosition: infos.currentPosition,
            duration: infos.duration,
            seekTo: (to) {
              BlocProvider.of<AudioBloc>(context).state.justAudioPlayer.seek(to);
            },
          );
        });
  }
}
