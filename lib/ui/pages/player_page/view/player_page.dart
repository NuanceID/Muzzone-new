import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/ui/pages/my_music/bloc/favourite_audios_bloc.dart';
import 'package:muzzone/ui/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../../logic/blocs/bottom_bar/bottom_bar_bloc.dart';
import '../../../../logic/functions/functions.dart';
import '../../../controllers/controllers.dart';
import '../bloc/audio_bloc.dart';
import '../widgets/widgets.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({Key? key, required this.scrollController})
      : super(key: key);

  static const id = '/player_page';

  final ScrollController scrollController;

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  final audioBloc = GetIt.I.get<AudioBloc>();
  final favouriteAudiosBloc = GetIt.I.get<FavouriteAudiosBloc>();

  final con = GetIt.I.get<MainController>();

  final bottomBarBloc = GetIt.I.get<BottomBarBloc>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        bottomBarBloc.add(ShowBottomBar());
        audioBloc.add(ShowMiniWidget());
        return Future.value(true);
      },
      child: Stack(
        children: [
          PageLayout(
            noSingleScroll: true,
            needBottomBar: false,
            needMiniPlayer: false,
            child: Container(
              child: con.player.builderCurrent(builder: (context, playing) {
                final myAudio =
                    con.find(con.audios, playing.audio.assetAudioPath);
                audioBloc.add(
                    CurrentPlaying(con.audios, playing.audio.assetAudioPath));
                return Column(
                  children: [
                    HeaderTitle(
                      needRotate: true,
                      onPress: () {
                        audioBloc.add(ClosePlayerWithButton());
                      },
                      title: LocaleKeys.now_playing.tr(),
                      // icon: 'tree_dots',
                      // iconColor: Theme.of(context).cardColor,
                      // iconPress: () =>
                      //     threeDotsFunction(context, myAudio, 'player_page'),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    PlayerImage(myAudio: myAudio),
                    SizedBox(
                      height: 3.h,
                    ),
                    PlayerAudioTitleText(myAudio: myAudio),
                    SizedBox(
                      height: 2.h,
                    ),
                    PlayerAudioArtist(myAudio: myAudio),
                    SizedBox(
                      height: 2.h,
                    ),
                    _buildPlayerPositionSeek(),
                    _buildPlayerButtons(),
                    SizedBox(height: 1.h),
                    const PlayerVolumeSlider(),
                    const Spacer(),
                    PlayerBottomButtons(
                      like: () {
                        favouriteAudiosBloc.add(
                            AddOrRemoveEvent(int.parse(myAudio.metas.id!)));
                      },
                      likeAdd: () {},
                      search: () {},
                      share: () => shareFunction('MuZZone', context, false),
                    )
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  PlayerBuilder _buildPlayerButtons() {
    return con.player.builderLoopMode(
      builder: (context, loopMode) {
        return PlayerBuilder.isPlaying(
            player: con.player,
            builder: (context, isPlaying) {
              return SizedBox(
                height: 12.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13.w),
                  child: PlayingController(
                    loopMode: loopMode,
                    isPlaying: isPlaying,
                    con: con,
                    isPlaylist: true,
                    onStop: () {
                      con.player.stop();
                    },
                    toggleLoop: () {
                      con.player.toggleLoop();
                    },
                    onPlay: () {
                      con.player.playOrPause();
                    },
                    onNext: () {
                      con.player.next();
                    },
                    onPrevious: () {
                      con.player.previous();
                    },
                  ),
                ),
              );
            });
      },
    );
  }

  PlayerBuilder _buildPlayerPositionSeek() {
    return con.player.builderRealtimePlayingInfos(
        builder: (context, RealtimePlayingInfos? infos) {
      if (infos == null) {
        return SizedBox(
          height: 9.h,
          width: double.infinity,
        );
      }
      return PlayerPositionSeekWidget(
        currentPosition: infos.currentPosition,
        duration: infos.duration,
        seekTo: (to) {
          con.player.seek(to);
        },
      );
    });
  }
}
