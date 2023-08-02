/*
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/ui/pages/my_music/widgets/my_music_songs_or_albums_item.dart';
import 'package:muzzone/ui/widgets/widgets.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../profile/bloc/profile_bloc.dart';
import '../../profile/setting_profile/view/setting_profile_page.dart';
import '../../show_all_page/show_all_page.dart';
import '../widgets/my_music_song_item.dart';

class MyMediaLibraryPage extends StatelessWidget {
  static const id = 'MyMusicPage';

  const MyMediaLibraryPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: Column(
        children: [
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return HeaderTitle(
                title: state.name,
                needIconBack: false,
                icon: 'edit',
                iconColor: AppColors.primaryColor,
                iconPress: () =>
                    Navigator.of(context).pushNamed(SettingProfilePage.id),
              );
            },
          ),
          MyMusicSongsItem(
            fromPage: 'my_music',
            title: LocaleKeys.recently.tr(),
            audios: con.audios,
            onPressShowAll: () {
              Navigator.of(context).pushNamed(ShowAllPage.id,
                  arguments: ShowAllPageArguments(
                      item: con.audios,
                      title: LocaleKeys.recently.tr(),
                      fromPage: 'my_music'));
            },
          ),
          MyMusicSongsOrAlbumItem(
            fromPage: 'my_music_playlists',
            title: LocaleKeys.playlists.tr(),
            count: LocalPlaylistsRepository.localPlaylists.length,
            playlists: LocalPlaylistsRepository.localPlaylists,
          ),
          BlocBuilder<FavouriteAudiosBloc, FavouriteAudiosState>(
            builder: (context, state) {
              if (state.favouriteList.isNotEmpty) {
                return MyMusicSongsItem(
                  fromPage: 'my_music',
                  title: LocaleKeys.liked_songs.tr(),
                  audios: state.favouriteList,
                  onPressShowAll: () {
                    Navigator.of(context).pushNamed(ShowAllPage.id,
                        arguments: ShowAllPageArguments(
                            item: state.favouriteList,
                            title: LocaleKeys.recently.tr(),
                            fromPage: 'my_music'));
                  },
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
*/
