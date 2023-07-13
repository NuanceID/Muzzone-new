import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muzzone/ui/pages/search/widgets/search_special_genre_page/search_special_genres_page.dart';
import 'package:muzzone/ui/pages/show_all_page/show_all_page.dart';

import '../../../config/config.dart';

class PlaylistsRow extends StatelessWidget {
  const PlaylistsRow(
      {Key? key, required this.playlists, required this.fromPage})
      : super(key: key);

  final List<dynamic> playlists;
  final String fromPage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: availableHeight / 4,
      child: ListView.builder(
        itemCount: playlists.length > 4 ? 5 : playlists.length,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: availableHeight / 4,
            height: availableHeight / 4,
            margin: EdgeInsets.only(
                left: index == 0 ? 14.w : 0,
                right: index == playlists.length - 1 ? 14.w : 12.w),
            child: _buildPopularAndYour(context, playlists[index].image,
                playlists[index].title, true, playlists, index),
          );
        },
      ),
    );
  }

  Widget _buildPopularAndYour(BuildContext context, asset, text, needImage,
      List<dynamic> playlists, int index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(7.r),
        onTap: () {
          if (playlists[index].title == 'По жанру') {
            Navigator.of(context).pushNamed(SearchSpecialGenresPage.id,
                arguments: ShowAllPageArguments(
                    item: playlists,
                    title: playlists[index].title,
                    fromPage: fromPage));
          } else {
            Navigator.of(context).pushNamed(ShowAllPage.id,
                arguments: ShowAllPageArguments(
                    fromPage: fromPage,
                    item: playlists[index],
                    id: playlists[index].id,
                    title: playlists[index].title));
          }
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.r),
            image: needImage
                ? DecorationImage(
              image: text == 'По жанру'
                  ? AssetImage(asset)
                  : CachedNetworkImageProvider(asset) as ImageProvider,
              fit: BoxFit.cover,
            )
                : null,
          ),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 17.sp, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      )
    );
  }
}
