import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel/sliding_up_panel_bloc.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel/sliding_up_panel_event.dart';
import 'package:muzzone/main.dart';
import 'package:muzzone/ui/widgets/layout_widgets/audio_row.dart';

import '../../../../config/routes/arguments/album_page_arguments.dart';
import '../../my_media_page/widgets/playlist_row.dart';
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
  const ColumnMusicAndAlbumsArtistPage({
    Key? key,
    required this.args,
    required this.index,
    required this.isPopularSongs,
  }) : super(key: key);

  final dynamic args;
  final int index;
  final bool isPopularSongs;


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
                BlocProvider.of<SlidingUpPanelBloc>(context).add(OpenMiniPlayer());
                audioHandler.playFromMediaId(args[i].id);
              },
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
            ),
      ],
    );
  }
}
