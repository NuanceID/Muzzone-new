import 'package:audio_service/audio_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzone/config/constants/constants.dart';
import 'package:muzzone/logic/blocs/audio/audio_event.dart';
import 'package:muzzone/main.dart';
import 'package:muzzone/ui/controllers/player_buttons.dart';
import 'package:muzzone/ui/widgets/widgets.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../../logic/blocs/audio/audio_bloc.dart';
import '../widgets/widgets.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  static const id = '/player_page';

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('LOG_TAG I AM HERE 1 ');
        BlocProvider.of<AudioBloc>(context).add(CloseSlidingPanel());
        return false;
      },
      child: SizedBox(
        height: availableHeight,
        child: StreamBuilder<MediaItem?>(
          stream: audioHandler.mediaItem,
          builder: (context, snapshot) {
            final mediaItem = snapshot.data;
            if (mediaItem == null) return const SizedBox();

            return Stack(
              children: [
                Positioned.fill(
                    child: Column(
                      children: [
                        Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: HeaderTitle(
                              needRotate: true,
                              onPress: () {
                                print('LOG_TAG I AM HERE 2 ');
                                BlocProvider.of<AudioBloc>(context).add(CloseSlidingPanel());
                              },
                              title: LocaleKeys.now_playing.tr(),
                            )),
                        const Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox.shrink(),
                        ),
                        Flexible(
                          flex: 15,
                          fit: FlexFit.tight,
                          child: Row(
                            children: [
                              const Flexible(
                                fit: FlexFit.tight,
                                child: SizedBox.shrink(),
                              ),
                              Flexible(
                                flex: 14,
                                fit: FlexFit.tight,
                                child: PlayerImage(
                                    myAudio: mediaItem),
                              ),
                              const Flexible(
                                fit: FlexFit.tight,
                                child: SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                        const Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox.shrink(),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Row(
                            children: [
                              const Flexible(
                                  fit: FlexFit.tight, child: SizedBox.shrink()),
                              Flexible(
                                  flex: 14,
                                  fit: FlexFit.tight,
                                  child: Text(
                                    mediaItem.title,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: Colors.black),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  )),
                              const Flexible(
                                  fit: FlexFit.tight, child: SizedBox.shrink()),
                            ],
                          ),
                        ),
                        const Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox.shrink(),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Row(
                            children: [
                              const Flexible(
                                  fit: FlexFit.tight, child: SizedBox.shrink()),
                              Flexible(
                                  flex: 14,
                                  fit: FlexFit.tight,
                                  child: Material(
                                      borderRadius: BorderRadius.circular(14.r),
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(14.r),
                                        onTap: () {},
                                        child: Ink(
                                          padding:
                                          EdgeInsets.all(availableHeight / 80),
                                          child: Text(
                                            mediaItem.artist ?? '',
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp,
                                                color: const Color(0xff90959B)),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ))),
                              const Flexible(
                                  fit: FlexFit.tight, child: SizedBox.shrink()),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          fit: FlexFit.tight,
                          child: _buildPlayerPositionSeek(),
                        ),
                        Flexible(
                          flex: 3,
                          fit: FlexFit.tight,
                          child: _buildPlayerButtons(),
                        ),
                        const Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: PlayerVolumeSlider(),
                        ),
                        const Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox.shrink(),
                        ),
                      ],
                    )),
                /*Positioned.fill(
                bottom: availableHeight/32,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: PlayerBottomButtons(
                    like: () {
                      favouriteAudiosBloc.add(AddOrRemoveEvent(
                      int.parse(myAudio.metas.id!)));
                    },
                    likeAdd: () {},
                    search: () {},
                    share: () =>
                        shareFunction('MuZZone', context, false),
                  )),)*/
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlayerButtons() {
    return Row(
      children: const [
        Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
        Flexible(
          flex: 9,
          fit: FlexFit.tight,
          child: PlayerButtons(),
        ),
        Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
      ],
    );
  }

  PlayerBuilder _buildPlayerPositionSeek() {
    return BlocProvider.of<AudioBloc>(context)
        .state
        .justAudioPlayer
        .builderRealtimePlayingInfos(
            builder: (context, RealtimePlayingInfos? infos) {
      if (infos == null) {
        return SizedBox(
          height: 10.h,
          width: double.infinity,
        );
      }

      return PlayerPositionSeekWidget(
        currentPosition: infos.currentPosition,
        duration: infos.duration,
        seekTo: (to) {
          BlocProvider.of<AudioBloc>(context).state.justAudioPlayer.seek(to);
        },
      );
    });
  }
}
