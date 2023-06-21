import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/config/style/style.dart';
import 'package:muzzone/config/utils/placeholders.dart';
import 'package:muzzone/data/repositories/remote_repositories/backend_repository.dart';
import 'package:muzzone/logic/blocs/trends/trends_bloc.dart';
import 'package:muzzone/logic/blocs/trends/trends_event.dart';
import 'package:muzzone/logic/blocs/trends/trends_state.dart';
import 'package:muzzone/ui/controllers/controllers.dart';
import 'package:muzzone/ui/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/routes/arguments/show_all_arguments.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../player_page/bloc/audio_bloc.dart';
import '../../show_all_page/show_all_page.dart';

import 'package:shimmer/shimmer.dart';

class MainPageInTrends extends StatelessWidget {
  MainPageInTrends({Key? key, required this.con}) : super(key: key);

  final MainController con;

  final audioBloc = GetIt.I.get<AudioBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TrendsBloc>(
        create: (BuildContext context) =>
            TrendsBloc(backendRepository: GetIt.I.get<BackendRepository>())
              ..add(const GetTrends()),
        child: _MainPageInTrends(
          con: con,
          audioBloc: audioBloc,
        ));
  }
}

class _MainPageInTrends extends StatefulWidget {
  const _MainPageInTrends(
      {super.key, required this.con, required this.audioBloc});

  final MainController con;
  final AudioBloc audioBloc;

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

      var audios = state.trends.tracks
          .map((e) => Audio.network(
                e.file,
                metas: Metas(
                  id: e.id.toString(),
                  title: e.name,
                  artist: e.name,
                  album: e.name,
                  extra: {
                    'isPopular': false,
                    'isNew': false,
                  },
                  image: MetasImage.network(e.cover),
                ),
              ))
          .toList();

      if (state.trendsStatus == TrendsStatus.success && audios.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  width: 100.w,
                  height:
                      (4.h + 2.05.h + 8.h + 2.h + 8.h + 2.h + 8.h + 2.h + 8.h),
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    LocaleKeys.no_content.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  )))
            ],
          ),
        );
      }

      if (state.trendsStatus == TrendsStatus.failure) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  width: 100.w,
                  height:
                      (4.h + 2.05.h + 8.h + 2.h + 8.h + 2.h + 8.h + 2.h + 8.h),
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    LocaleKeys.something_went_wrong.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  )))
            ],
          ),
        );
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TitleWithButtonShowAll(
            fromPage: 'main_page',
            title: LocaleKeys.in_trends.tr(),
            item: audios,
            onPress: () {
              Navigator.of(context).pushNamed(ShowAllPage.id,
                  arguments: ShowAllPageArguments(
                    item: audios,
                    id: state.trends.id,
                    title: LocaleKeys.in_trends.tr(),
                    fromPage: 'main_page',
                  ));
            },
          ),
          ListView.builder(
            padding: EdgeInsets.only(top: 2.h),
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: audios.length < 5 ? audios.length : 4,
            itemBuilder: (context, index) => AudioRow(
              audio: audios[index],
              height: 7.h,
              onPress: () {
                widget.con.playSong(audios, index);
                widget.audioBloc.add(StartPlaying(audios));
              },
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      );
    });
    /*return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TitleWithButtonShowAll(
          fromPage: 'main_page',
          title: LocaleKeys.in_trends.tr(),
          item: con.audios,
          onPress: () {
            Navigator.of(context).pushNamed(ShowAllPage.id,
                arguments: ShowAllPageArguments(
                    item: con.audios,
                    title: LocaleKeys.in_trends.tr(),
                    fromPage: 'main_page'));
          },
        ),
        ListView.builder(
          padding: EdgeInsets.only(top: 2.h),
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: LocalSongsRepository.localSongs.length,
          itemBuilder: (context, index) => AudioRow(
            audio: con.audios[index],
            height: 7.h,
            onPress: () {
              con.playSong(con.audios, index);
              audioBloc.add(StartPlaying(con.audios));
            },
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );*/
  }
}
