import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muzzone/ui/widgets/widgets.dart';

import '../../../../config/routes/arguments/album_page_arguments.dart';
import '../../../../data/models/playlist.dart';
import '../../../../data/models/track.dart';
import '../../search/widgets/search_chosen_genre_page/search_chosen_genre_page.dart';

class MyMusicSongsOrAlbumItem extends StatefulWidget {
  const MyMusicSongsOrAlbumItem(
      {Key? key,
        this.songs,
        this.playlists,
        this.myAudios,
        required this.count,
        required this.title,
        required this.fromPage})
      : super(key: key);

  final List<Track>? songs;
  final List<MyPlaylist>? playlists;
  final List<MediaItem>? myAudios;
  final int count;
  final String title;
  final String fromPage;

  @override
  State<MyMusicSongsOrAlbumItem> createState() =>
      _MyMusicSongsOrAlbumItemState();
}

class _MyMusicSongsOrAlbumItemState extends State<MyMusicSongsOrAlbumItem> {
  late List<dynamic> list;
  String nameNewPlaylist = '';

  //final Playlist playlist = Playlist();

  @override
  void initState() {
    if (widget.playlists != null) {
      list = widget.playlists!;
    } else {
      list = [];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 3.h,
        ),
        TitleWithButtonShowAll(
          fromPage: widget.fromPage,
          title: widget.title,
          item: list,
          createNewPlaylist: widget.fromPage == 'my_music_playlists'
              ? () {
            log('qu');
            if (widget.fromPage == 'my_music_playlists') {
              //Navigator.of(context).pushNamed(MyMediaPage.id);
            }
          }
              : null,
          onPress: () {
            //Navigator.of(context).pushNamed(MyMediaPage.id);
          },
        ),
        SizedBox(
          height: 2.h,
        ),
        for (var i = 0; i < 3; i++)
          PlaylistRow(
            onPress: () {
              Navigator.of(context).pushNamed(SearchChosenGenrePage.id,
                  arguments: AlbumPageArguments(
                      album: list[i].audios, title: list[i].name));
            },
            playlist: list[i],
            height: 10.h,
          ),
      ],
    );
  }
}
