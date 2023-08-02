import 'package:audio_service/audio_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzone/config/constants/constants.dart';
import 'package:muzzone/config/style/style.dart';
import 'package:muzzone/config/utils/placeholders.dart';
import 'package:muzzone/data/repositories/remote_repositories/backend_repository.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel/sliding_up_panel_bloc.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel/sliding_up_panel_event.dart';
import 'package:muzzone/logic/blocs/trends/trends_bloc.dart';
import 'package:muzzone/logic/blocs/trends/trends_event.dart';
import 'package:muzzone/logic/blocs/trends/trends_state.dart';
import 'package:muzzone/main.dart';
import 'package:muzzone/ui/widgets/widgets.dart';

import '../../../../config/routes/arguments/show_all_arguments.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../show_all_page/show_all_page.dart';

import 'package:shimmer/shimmer.dart';

class MainPageInTrends extends StatelessWidget {
  const MainPageInTrends({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TrendsBloc>(
        create: (BuildContext context) =>
            TrendsBloc(backendRepository: context.read<BackendRepository>())
              ..add(const GetTrends()),
        child: const _MainPageInTrends());
  }
}

class _MainPageInTrends extends StatefulWidget {
  const _MainPageInTrends();

  @override
  State<_MainPageInTrends> createState() => _MainPageInTrendsState();
}

class _MainPageInTrendsState extends State<_MainPageInTrends> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendsBloc, TrendsState>(builder: (context, state) {
      if (state.trendsStatus == TrendsStatus.loading ||
          state.trendsStatus == TrendsStatus.initial) {
        return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: const SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: TrendsPlaceholder(),
            ));
      }

      var playlist = state.trends.tracks
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

      if (state.trendsStatus == TrendsStatus.success && playlist.isEmpty) {
        return SizedBox(
            height: availableHeight / 2.42,
            child: Center(
                child: Text(LocaleKeys.no_content.tr(),
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: AppColors.primaryColor,
                    ))));
      }

      if (state.trendsStatus == TrendsStatus.failure) {
        return SizedBox(
            height: availableHeight / 2.42,
            child: Center(
                child: Text(
              LocaleKeys.something_went_wrong.tr(),
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: AppColors.primaryColor,
              ),
            )));
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
              child: TitleWithButtonShowAll(
            fromPage: 'main_page',
            title: LocaleKeys.in_trends.tr(),
            item: playlist,
            onPress: () async {
              if (mounted) {
                Navigator.of(context).pushNamed(ShowAllPage.id,
                    arguments: ShowAllPageArguments(
                      item: playlist,
                      id: state.trends.id,
                      title: LocaleKeys.in_trends.tr(),
                      fromPage: 'main_page',
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
