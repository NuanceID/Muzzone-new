import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/ui/pages/player_page/widgets/player_bottom_position_seek.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config.dart';
import '../../../logic/blocs/bottom_bar/bottom_bar_bloc.dart';
import '../../controllers/controllers.dart';
import '../../pages/my_music/bloc/favourite_audios_bloc.dart';
import '../../pages/player_page/bloc/audio_bloc.dart';
import '../widgets.dart';

class BottomPlayerWidget extends StatelessWidget {
  BottomPlayerWidget({Key? key, required this.onPress}) : super(key: key);

  final con = GetIt.I.get<MainController>();
  final bottomBarBloc = GetIt.I.get<BottomBarBloc>();
  final audioBloc = GetIt.I.get<AudioBloc>();
  final VoidCallback onPress;

  final favouriteAudiosBloc = GetIt.I.get<FavouriteAudiosBloc>();

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return con.player.builderCurrent(builder: (context, playing) {
      final myAudio = con.find(con.audios, playing.audio.assetAudioPath);
      return BlocBuilder<AudioBloc, AudioState>(
        builder: (context, state) {
          if (!state.showMiniWidget) {
            return GestureDetector(
              onTap: () {
                onPress();
              },
              child: Container(
                height: Space.bottomBarHeight * 2,
                width: 100.w,
                padding: EdgeInsets.only(left: 7.w, right: 4.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 3,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Space.bottomBarHeight - 1.h,
                      child: Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(3),
                                  child: CachedNetworkImage(
                                    imageUrl: myAudio.metas.image!.path,
                                    width: 35.sp,
                                    height: 35.sp,
                                    memCacheHeight:
                                        (70 * devicePixelRatio).round(),
                                    memCacheWidth:
                                        (70 * devicePixelRatio).round(),
                                    maxHeightDiskCache:
                                        (70 * devicePixelRatio).round(),
                                    maxWidthDiskCache:
                                        (70 * devicePixelRatio).round(),
                                    progressIndicatorBuilder:
                                        (context, url, l) =>
                                            const LoadingImage(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 3.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        myAudio.metas.title!,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Theme.of(context)
                                              .secondaryHeaderColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      Text(
                                        myAudio.metas.artist!,
                                        style: const TextStyle(
                                            color: AppColors.greyColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            PlayerBuilder.isPlaying(
                              player: con.player,
                              builder: (context, isPlaying) {
                                return BottomPlayingController(
                                  addToFavourite: () {
                                    favouriteAudiosBloc.add(AddOrRemoveEvent(
                                        int.parse(myAudio.metas.id!)));
                                  },
                                  isPlaylist: true,
                                  con: con,
                                  onPlay: () {
                                    con.player.playOrPause();
                                  },
                                  isPlaying: isPlaying,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.7.h,
                    ),
                    _buildPlayerPositionSeek(),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      );
    });
  }

  PlayerBuilder _buildPlayerPositionSeek() {
    return con.player.builderRealtimePlayingInfos(
        builder: (context, RealtimePlayingInfos? infos) {
      if (infos == null) {
        return Container();
      }
      return PlayerBottomPositionSeek(
        currentPosition: infos.currentPosition,
        duration: infos.duration,
        seekTo: (to) {
          con.player.seek(to);
        },
      );
    });
  }
}
