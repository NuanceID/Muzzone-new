import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muzzone/ui/pages/search/widgets/search_special_genre_page/search_special_genres_page.dart';
import 'package:muzzone/ui/pages/show_all_page/show_all_page.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config.dart';

class PlaylistsRow extends StatelessWidget {
  const PlaylistsRow(
      {Key? key, required this.playlists, required this.fromPage})
      : super(key: key);

  final List<dynamic> playlists;
  final String fromPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.sp,
      padding: EdgeInsets.only(left: 0.w),
      child: ListView.builder(
        itemCount: playlists.length > 4 ? 5 : playlists.length,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
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
            child: Container(
              width: 120.sp,
              height: 120.sp,
              margin: EdgeInsets.only(
                  left: index == 0 ? 7.w : 0,
                  right: index == playlists.length - 1 ? 7.w : 3.w),
              child: _buildPopularAndYour(
                context,
                playlists[index].image,
                playlists[index].title,
                true //playlists.length > 5 ? true : false,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPopularAndYour(BuildContext context, asset, text, needImage) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: needImage ? null : Colors.grey,
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
          style:
              Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15.sp),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
