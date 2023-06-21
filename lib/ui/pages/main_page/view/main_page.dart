import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/config/style/style.dart';
import 'package:muzzone/config/utils/placeholders.dart';
import 'package:muzzone/logic/blocs/categories/categories_bloc.dart';
import 'package:muzzone/logic/blocs/categories/categories_event.dart';
import 'package:muzzone/logic/blocs/categories/categories_state.dart';
import 'package:muzzone/logic/blocs/genres/genres_bloc.dart';
import 'package:muzzone/logic/blocs/genres/genres_event.dart';
import 'package:muzzone/logic/blocs/genres/genres_state.dart';
import 'package:muzzone/logic/blocs/playlists/playlists_bloc.dart';
import 'package:muzzone/logic/blocs/playlists/playlists_event.dart';
import 'package:muzzone/logic/blocs/playlists/playlists_state.dart';
import 'package:muzzone/ui/controllers/controllers.dart';
import 'package:muzzone/ui/pages/main_page/widgets/main_header_title.dart';
import 'package:muzzone/ui/pages/main_page/widgets/main_page_in_trends.dart';
import 'package:muzzone/ui/widgets/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../generated/locale_keys.g.dart';
import '../widgets/playlists_main.dart';

class MainPage extends StatefulWidget {
  static const id = 'MainPage';

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  /*late List<MyPlaylist> playlists = [];
  late List<MyPlaylist> genres = [];*/

  /*late List<MyPlaylist> language = [
    LocalPlaylistsRepository.localPlaylists[0],
    LocalPlaylistsRepository.localPlaylists[1],
    LocalPlaylistsRepository.localPlaylists[2],
  ];*/

  final con = GetIt.I.get<MainController>();

  @override
  void initState() {
    /*for (var element in LocalPlaylistsRepository.localPlaylists) {
      if (element.isGenre == false && element.isLanguage == false) {
        playlists.add(element);
      } else if (element.isLanguage == false) {
        genres.add(element);
      }
    }*/

    super.initState();
    GetIt.I.get<GenresBloc>().add(const GetGenres());
    GetIt.I.get<PlaylistsBloc>().add(const GetPlaylists());
    GetIt.I.get<CategoriesBloc>().add(const GetCategories());
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      children: [
        SizedBox(
          height: 5.h,
        ),
        MainHeaderTitle(),
        SizedBox(
          height: 3.h,
        ),
        MainPageInTrends(
          con: con,
        ),
        SizedBox(
          height: 2.h,
        ),
        BlocBuilder<PlaylistsBloc, PlaylistsState>(builder: (context, state) {
          if (state.playlistsStatus == PlaylistsStatus.loading ||
              state.playlistsStatus == PlaylistsStatus.initial) {
            return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: const SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: MainTilePlaceholder(),
                ));
          }

          if (state.playlistsStatus == PlaylistsStatus.success &&
              state.list.isEmpty) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                    width: double.infinity,
                    height: (4.h + 2.05.h + 120.sp),
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      LocaleKeys.no_content.tr(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ))));
          }

          if (state.playlistsStatus == PlaylistsStatus.failure) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                    width: double.infinity,
                    height: (4.h + 2.05.h + 120.sp),
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      LocaleKeys.something_went_wrong.tr(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ))));
          }

          return PlaylistsMainPage(
            list: state.list,
            title: LocaleKeys.playlists.tr(),
          );
        }),
        SizedBox(
          height: 4.h,
        ),
        BlocBuilder<GenresBloc, GenresState>(builder: (context, state) {
          if (state.genresStatus == GenresStatus.loading ||
              state.genresStatus == GenresStatus.initial) {
            return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: const SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: MainTilePlaceholder(),
                ));
          }

          if (state.genresStatus == GenresStatus.success &&
              state.genresList.isEmpty) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                    width: double.infinity,
                    height: (4.h + 2.05.h + 120.sp),
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      LocaleKeys.no_content.tr(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ))));
          }

          if (state.genresStatus == GenresStatus.failure) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                    width: double.infinity,
                    height: (4.h + 2.05.h + 120.sp),
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      LocaleKeys.something_went_wrong.tr(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ))));
          }

          return PlaylistsMainPage(
            list: state.genresList,
            title: LocaleKeys.genres.tr(),
          );
        }),
        SizedBox(
          height: 4.h,
        ),
        BlocBuilder<CategoriesBloc, CategoriesState>(builder: (context, state) {
          if (state.categoriesStatus == CategoriesStatus.loading ||
              state.categoriesStatus == CategoriesStatus.initial) {
            return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: const SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: MainTilePlaceholder(),
                ));
          }

          if (state.categoriesStatus == CategoriesStatus.success &&
              state.categoriesList.isEmpty) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                    width: double.infinity,
                    height: (4.h + 2.05.h + 120.sp),
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      LocaleKeys.no_content.tr(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ))));
          }

          if (state.categoriesStatus == CategoriesStatus.failure) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                    width: double.infinity,
                    height: (4.h + 2.05.h + 120.sp),
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      LocaleKeys.something_went_wrong.tr(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ))));
          }

          return PlaylistsMainPage(
            list: state.categoriesList,
            title: LocaleKeys.language_affiliation.tr(),
          );
        }),
      ],
    );
  }
}
