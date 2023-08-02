import 'package:audio_service/audio_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzone/config/constants/constants.dart';
import 'package:muzzone/config/style/style.dart';
import 'package:muzzone/config/utils/placeholders.dart';
import 'package:muzzone/logic/blocs/recent_tracks/recent_tracks_bloc.dart';
import 'package:muzzone/logic/blocs/recent_tracks/recent_tracks_state.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel/sliding_up_panel_bloc.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel/sliding_up_panel_event.dart';
import 'package:muzzone/main.dart';
import 'package:muzzone/ui/widgets/widgets.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../config/routes/arguments/show_all_arguments.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../show_all_page/show_all_page.dart';

class RecentTracks extends StatelessWidget {
  const RecentTracks({super.key});

  @override
  Widget build(BuildContext context) {
    return const _RecentTracks();
  }
}

class _RecentTracks extends StatefulWidget {
  const _RecentTracks();

  @override
  State<_RecentTracks> createState() => _RecentTracksState();
}

class _RecentTracksState extends State<_RecentTracks> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentTracksBloc, RecentTracksState>(
        builder: (context, state) {
      if (state.recentTracksStatus == RecentTracksStatus.loading ||
          state.recentTracksStatus == RecentTracksStatus.initial) {
        return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: const SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: TrendsPlaceholder(),
            ));
      }

      var playlist = state.recentTracks
          .map((e) => MediaItem(
                id: e.file,
                title: e.name,
                album: e.album.name,
                artist: e.artists
                    .map((element) => element.name)
                    .toList()
                    .join(', '),
                artUri: Uri.parse(e.cover),
              ))
          .toList();

      if (state.recentTracksStatus == RecentTracksStatus.success &&
          playlist.isEmpty) {
        return SizedBox(
            height: availableHeight / 5.42,
            child: Center(
                child: Text(LocaleKeys.no_recent_tracks.tr(),
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: AppColors.primaryColor,
                    ))));
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
              child: TitleWithButtonShowAll(
            fromPage: 'my_media',
            title: LocaleKeys.recent_tracks.tr(),
            item: playlist,
            onPress: () async {
              if (mounted) {
                Navigator.of(context).pushNamed(ShowAllPage.id,
                    arguments: ShowAllPageArguments(
                      item: playlist,
                      title: LocaleKeys.recent_tracks.tr(),
                      fromPage: 'my_media',
                    ));
              }
            },
          )),
          Flexible(
            child: SizedBox(
              height: availableHeight / 30,
            ),
          ),
          Flexible(
              child: ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: playlist.length < 5 ? playlist.length : 4,
            itemBuilder: (context, index) => AudioRow(
              audio: playlist[index],
              onPress: () async {
                await audioHandler.updateQueue(<MediaItem>[]);
                await audioHandler.addQueueItems(playlist);
                if (mounted) {
                  BlocProvider.of<SlidingUpPanelBloc>(context)
                      .add(OpenMiniPlayer());
                }
                await audioHandler.playFromMediaId(playlist[index].id);
              },
            ),
          )),
        ],
      );
    });
  }
}
