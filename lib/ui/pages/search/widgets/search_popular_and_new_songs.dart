import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:muzzone/config/style/style.dart';
import 'package:muzzone/data/models/track.dart';
import 'package:muzzone/generated/locale_keys.g.dart';
import 'package:muzzone/ui/controllers/controllers.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/layout_widgets/audio_row.dart';
import '../../player_page/bloc/audio_bloc.dart';

class SearchPopularAndNewSongs extends StatelessWidget {
  SearchPopularAndNewSongs(
      {Key? key, required this.pagingController, required this.isPopular})
      : super(key: key);

  final PagingController<int, Track> pagingController;
  final bool isPopular;
  final con = GetIt.I.get<MainController>();
  final audioBloc = GetIt.I.get<AudioBloc>();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        PagedSliverList<int, Track>(
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate<Track>(
              noItemsFoundIndicatorBuilder: (_) => Center(
                  child: Text(
                    LocaleKeys.no_content.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  )),
              firstPageErrorIndicatorBuilder: (_) => Center(
                  child: Text(
                    LocaleKeys.something_went_wrong.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  )),
              newPageErrorIndicatorBuilder: (_) => Center(
                  child: Text(
                    LocaleKeys.something_went_wrong.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  )),
              itemBuilder: (context, item, index) => AudioRow(
                height: 7.h,
                audio: Audio.network(
                  item.file,
                  metas: Metas(
                    id: item.id.toString(),
                    title: item.name,
                    artist: item.name,
                    album: item.name,
                    extra: {
                      'isPopular': false,
                      'isNew': false,
                    },
                    image: MetasImage.network(item.cover),
                  ),
                ),
                onPress: () {
                  con.playSong(con.audios, index);
                  audioBloc.add(StartPlaying(con.audios));
                },
              )),
        )
      ],
    );
  }
}

/*class SearchPopularAndNewSongs extends StatelessWidget {
  SearchPopularAndNewSongs(
      {Key? key, required this.songs, required this.isPopular})
      : super(key: key);

  final List<Audio> songs;
  final bool isPopular;
  final con = GetIt.I.get<MainController>();
  final audioBloc = GetIt.I.get<AudioBloc>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return AudioRow(
            audio: songs[index],
            height: 7.h,
            onPress: () {
              con.playSong(songs, index);
              audioBloc.add(StartPlaying(songs));
            },
          );
        });
  }
}*/
