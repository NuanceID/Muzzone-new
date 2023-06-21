import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/ui/widgets/layout_widgets/audio_row.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/routes/arguments/album_page_arguments.dart';
import '../../../controllers/controllers.dart';
import '../../../widgets/layout_widgets/playlist_row.dart';
import '../../player_page/bloc/audio_bloc.dart';
import '../../search/widgets/search_chosen_genre_page/search_chosen_genre_page.dart';

class PageViewArtistPage extends StatelessWidget {
  const PageViewArtistPage({
    Key? key,
    required PageController pageController,
    required this.args,
    required this.isPopularSongs,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;
  final dynamic args;
  final bool isPopularSongs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 27.h,
      child: PageView.builder(
        allowImplicitScrolling: true,
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) {
          return ColumnMusicAndAlbumsArtistPage(
            isPopularSongs: isPopularSongs,
            index: index,
            args: args,
          );
        },
      ),
    );
  }
}

class ColumnMusicAndAlbumsArtistPage extends StatelessWidget {
  ColumnMusicAndAlbumsArtistPage({
    Key? key,
    required this.args,
    required this.index,
    required this.isPopularSongs,
  }) : super(key: key);

  final dynamic args;
  final int index;
  final bool isPopularSongs;

  final MainController con = GetIt.I.get<MainController>();
  final audioBloc = GetIt.I.get<AudioBloc>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < 3; i++)
          if (isPopularSongs)
            AudioRow(
              paddingLeft: 2.w,
              audio: args[i],
              onPress: () {
                con.playSong(con.audios, index);
                audioBloc.add(StartPlaying(con.audios));
              },
              height: 7.h,
            )
          else
            PlaylistRow(
              onPress: () {
                Navigator.of(context).pushNamed(
                  SearchChosenGenrePage.id,
                  arguments: AlbumPageArguments(
                    album: args[i].audios,
                    title: args[i].name,
                  ),
                );
              },
              playlist: args[i],
              paddingLeft: 2.w,
              height: 7.h,
            ),
      ],
    );
  }
}
