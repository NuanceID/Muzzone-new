import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:muzzone/generated/locale_keys.g.dart';
import 'package:muzzone/ui/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../config/routes/arguments/album_page_arguments.dart';
import '../../../../../../config/routes/arguments/show_all_arguments.dart';
import '../../../../../../data/data.dart';
import '../../../../../../logic/functions/alert_dialog_create_playlist.dart';
import '../../../../../widgets/layout_widgets/playlist_row.dart';
import '../../../../search/widgets/search_chosen_genre_page/search_chosen_genre_page.dart';
import '../../../../show_all_page/show_all_page.dart';

class MyMediaPage extends StatefulWidget {
  static const id = 'MyMediaPage';

  const MyMediaPage({Key? key}) : super(key: key);

  @override
  State<MyMediaPage> createState() => _MyMediaPageState();
}

class _MyMediaPageState extends State<MyMediaPage> {
  String nameNewPlaylist = '';
  late List<MyPlaylist> list;

  @override
  void initState() {
    list = LocalPlaylistsRepository.localPlaylists;
    super.initState();
  }

  void _buildAlertDialogCreatePlaylist(BuildContext context) {
    return alertDialogCreatePlaylist(
      context,
      (value) {
        setState(() {
          nameNewPlaylist = value;
        });
      },
      () => _addNewPlaylist(context),
    );
  }

  void _addNewPlaylist(BuildContext context) {
    if (nameNewPlaylist != '') {
      setState(() {
        list.add(
          MyPlaylist(
            isLanguage: false,
            id: 8423,
            title: nameNewPlaylist,
            audios: [],
            image: 'popular',
            isGenre: false,
            isAlbum: true,
          ),
        );
        nameNewPlaylist = '';
      });
    }
    setState(() {});
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      children: [
        HeaderTitle(
          title: LocaleKeys.my_media.tr(),
        ),
        SizedBox(
          height: 3.h,
        ),
        TitleWithButtonShowAll(
          title: LocaleKeys.my_playlists.tr(),
          item: list,
          fromPage: 'my_media',
          isPlaylists: true,
          createNewPlaylist: () => _buildAlertDialogCreatePlaylist(context),
          onPress: () {
            Navigator.of(context).pushNamed(ShowAllPage.id,
                arguments: ShowAllPageArguments(
                    //item: list,
                    title: LocaleKeys.my_playlists.tr(),
                    fromPage: 'main_page'));
          },
        ),
        SizedBox(
          height: 4.h,
        ),
        for (var i = 0; i < list.length; i++)
          PlaylistRow(
            playlist: list[i],
            onPress: () {
              Navigator.of(context).pushNamed(
                SearchChosenGenrePage.id,
                arguments: AlbumPageArguments(
                  album: list[i].audios,
                  title: list[i].title,
                ),
              );
            },
            height: 10.h,
          ),
      ],
    );
  }
}
