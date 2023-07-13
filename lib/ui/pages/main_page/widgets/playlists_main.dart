import 'package:flutter/material.dart';
import 'package:muzzone/config/constants/constants.dart';
import 'package:muzzone/ui/widgets/widgets.dart';

import '../../../../config/routes/arguments/show_all_arguments.dart';
import '../../show_all_page/show_all_page.dart';

class PlaylistsMainPage extends StatelessWidget {
  const PlaylistsMainPage({Key? key, required this.list, required this.title})
      : super(key: key);

  final List<dynamic> list;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TitleWithButtonShowAll(
            fromPage: 'main_page',
            title: title,
            item: list,
            onPress: () {
              Navigator.of(context).pushNamed(ShowAllPage.id,
                  arguments: ShowAllPageArguments(
                      item: list, title: title, fromPage: 'main_page'));
            },
          ),
        ),
        Flexible(
          child: SizedBox(
            height: availableHeight / 40,
          ),
        ),
        Flexible(
          child: PlaylistsRow(
            playlists: list,
            //fromPage: 'main_page',
            fromPage: 'playlists_row',
          ),
        ),
      ],
    );
  }
}
