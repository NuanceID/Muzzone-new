import 'package:audio_service/audio_service.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzone/config/constants/constants.dart';
import 'package:muzzone/data/models/album.dart';
import 'package:muzzone/data/models/artist.dart';
import 'package:muzzone/data/models/track.dart';
import 'package:muzzone/logic/blocs/recent_tracks/recent_tracks_bloc.dart';
import 'package:muzzone/logic/blocs/recent_tracks/recent_tracks_event.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel/sliding_up_panel_bloc.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel/sliding_up_panel_event.dart';
import 'package:muzzone/main.dart';
import 'package:muzzone/ui/pages/player_page/widgets/player_buttons.dart';
import 'package:muzzone/ui/pages/player_page/widgets/player_image.dart';
import 'package:muzzone/ui/pages/player_page/widgets/player_position_seek_widget.dart';
import 'package:muzzone/ui/pages/player_page/widgets/player_volume_slider.dart';
import 'package:muzzone/ui/widgets/widgets.dart';

import '../../../../generated/locale_keys.g.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  static const id = '/player_page';

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: availableHeight,
      child: StreamBuilder<MediaItem?>(
        stream: audioHandler.mediaItem,
        builder: (context, snapshot) {
          final mediaItem = snapshot.data;
          if (mediaItem == null) return const SizedBox.shrink();

          var currentTrack = Track(
              id: -1,
              name: mediaItem.title,
              description: '',
              cover: mediaItem.artUri.toString(),
              file: mediaItem.id,
              album: const Album(),
              artists: mediaItem.artist != null
                  ? <Artist>[Artist(name: mediaItem.artist!)]
                  : const <Artist>[],
              genres: '',
              audio: '',
              isPopular: -1,
              isNew: -1);

          var isAnotherTrack = BlocProvider.of<RecentTracksBloc>(context)
                  .state
                  .currentTrack
                  .name !=
              currentTrack.name;

          if (isAnotherTrack) {
            BlocProvider.of<RecentTracksBloc>(context)
                .add(SetCurrentTrack(track: currentTrack));
            BlocProvider.of<RecentTracksBloc>(context)
                .add(PutTrack(track: currentTrack));
          }

          return Stack(
            children: [
              Positioned.fill(
                  child: Column(
                children: [
                  Flexible(
                      flex: 12,
                      fit: FlexFit.tight,
                      child: HeaderTitle(
                        needRotate: true,
                        onPress: () {
                          BlocProvider.of<SlidingUpPanelBloc>(context)
                              .add(CloseSlidingPanel());
                        },
                        title: LocaleKeys.now_playing.tr(),
                      )),
                  const Flexible(
                    fit: FlexFit.tight,
                    child: SizedBox.shrink(),
                  ),
                  Flexible(
                    flex: 58,
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
                          child: PlayerImage(myAudio: mediaItem),
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
                    flex: 12,
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
                                  fontSize: 16.sp,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            )),
                        const Flexible(
                            fit: FlexFit.tight, child: SizedBox.shrink()),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 12,
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
                                          fontSize: 14.sp,
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
                  const Flexible(
                    fit: FlexFit.tight,
                    child: SizedBox.shrink(),
                  ),
                  const Flexible(
                    flex: 16,
                    fit: FlexFit.tight,
                    child: PlayerPositionSeekWidget(),
                  ),
                  Flexible(
                    flex: 16,
                    fit: FlexFit.tight,
                    child: Row(
                      children: const [
                        Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
                        Flexible(
                          flex: 9,
                          fit: FlexFit.tight,
                          child: PlayerButtons(),
                        ),
                        Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
                      ],
                    ),
                  ),
                  const Flexible(
                    flex: 8,
                    fit: FlexFit.tight,
                    child: PlayerVolumeSlider(),
                  ),
                  SizedBox(
                    height: availableHeight / 12,
                  ),
                  const Flexible(
                    fit: FlexFit.tight,
                    child: SizedBox.shrink(),
                  ),
                ],
              )),
            ],
          );
        },
      ),
    );
  }
}
