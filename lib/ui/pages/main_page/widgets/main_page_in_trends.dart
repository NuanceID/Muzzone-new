import 'package:audio_service/audio_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muzzone/config/constants/constants.dart';
import 'package:muzzone/config/style/style.dart';
import 'package:muzzone/config/utils/placeholders.dart';
import 'package:muzzone/data/repositories/remote_repositories/backend_repository.dart';
import 'package:muzzone/logic/blocs/audio/audio_event.dart';
import 'package:muzzone/logic/blocs/trends/trends_bloc.dart';
import 'package:muzzone/logic/blocs/trends/trends_event.dart';
import 'package:muzzone/logic/blocs/trends/trends_state.dart';
import 'package:muzzone/ui/widgets/widgets.dart';

import '../../../../config/routes/arguments/show_all_arguments.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../logic/blocs/audio/audio_bloc.dart';
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
    BlocProvider.of<AudioBloc>(context).add(ClearPlaylist());

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
        artist: e.artists.map((element) => element.name).toList().join(', '),
        artUri: Uri.parse(e.cover),

      )).toList();

      BlocProvider.of<AudioBloc>(context).add(SetPlaylist(
          playlist: playlist));

      if (state.trendsStatus == TrendsStatus.success && playlist.isEmpty) {
        return SizedBox(
            height: availableHeight / 2.42,
            child: Center(
                child: Text(
              LocaleKeys.no_content.tr(),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            )));
      }

      if (state.trendsStatus == TrendsStatus.failure) {
        return SizedBox(
            height: availableHeight / 2.42,
            child: Center(
                child: Text(
              LocaleKeys.something_went_wrong.tr(),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
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
            onPress: () {
              Navigator.of(context).pushNamed(ShowAllPage.id,
                  arguments: ShowAllPageArguments(
                    item: playlist,
                    id: state.trends.id,
                    title: LocaleKeys.in_trends.tr(),
                    fromPage: 'main_page',
                  ));
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
              onPress: () {
                print('LOG_TAG I AM HERE');
                BlocProvider.of<AudioBloc>(context).add(OpenMiniPlayer());
                BlocProvider.of<AudioBloc>(context)
                    .add(Play(audioPath: playlist[index].id));
              },
            ),
          )),
        ],
      );
    });
  }
}
