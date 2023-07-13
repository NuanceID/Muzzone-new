import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/ui/pages/artist/widgets/artist_page_header_title.dart';
import 'package:muzzone/ui/pages/artist/widgets/page_view_artist_page.dart';
import 'package:muzzone/ui/widgets/widgets.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../show_all_page/show_all_page.dart';

class ArtistPage extends StatefulWidget {
  const ArtistPage({Key? key}) : super(key: key);

  static const id = '/artist_page';

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  late PageController _popularMusicController;
  late PageController _albumsController;

  @override
  void initState() {
    _popularMusicController =
        PageController(viewportFraction: 0.9, initialPage: 0);
    _albumsController = PageController(viewportFraction: 0.9, initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _popularMusicController.dispose();
    _albumsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)!.settings.arguments as ArtistPageArguments;

    return Column(
      children: [
        ArtistPageHeaderTitle(
          image: '$imagesPath${args.artist.cover}.jpg',
          name: args.artist.name,
        ),
        SizedBox(
          height: 14.h,
        ),
        TitleWithButtonShowAll(
          fromPage: 'artist_page',
          title: LocaleKeys.popular.tr(),
          item: args.artist.audio,
          onPress: () {
            Navigator.of(context).pushNamed(ShowAllPage.id,
                arguments: ShowAllPageArguments(
                  //item: args.artist.audio,
                    title: LocaleKeys.popular.tr(),
                    fromPage: 'artist_page'));
          },
        ),
        SizedBox(
          height: 12.h,
        ),
        PageViewArtistPage(
          pageController: _popularMusicController,
          args: args.artist.audio,
          isPopularSongs: true,
        ),
        TitleWithButtonShowAll(
          fromPage: 'artist_page',
          title: LocaleKeys.all_albums.tr(),
          item: args.artist.albums,
          onPress: () {
            Navigator.of(context).pushNamed(ShowAllPage.id,
                arguments: ShowAllPageArguments(
                  //item: args.artist.albums,
                    title: LocaleKeys.popular.tr(),
                    fromPage: 'artist_page'));
          },
        ),
        SizedBox(
          height: 2.h,
        ),
        PageViewArtistPage(
          isPopularSongs: false,
          pageController: _albumsController,
          args: args.artist.albums,
        ),
      ],
    );
  }
}
