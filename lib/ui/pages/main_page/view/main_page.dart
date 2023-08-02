import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzone/config/constants/constants.dart';
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
import 'package:muzzone/ui/pages/main_page/widgets/main_header_title.dart';
import 'package:muzzone/ui/pages/main_page/widgets/main_page_in_trends.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../generated/locale_keys.g.dart';
import '../widgets/playlists_main.dart';

class MainPage extends StatefulWidget {
  static const id = 'MainPage';

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with AutomaticKeepAliveClientMixin<MainPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GenresBloc>(context).add(const GetGenres());
    BlocProvider.of<PlaylistsBloc>(context).add(const GetPlaylists());
    BlocProvider.of<CategoriesBloc>(context).add(const GetCategories());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: SizedBox(height: availableHeight / 33.4),
                    ),
                    const Flexible(
                      child: MainHeaderTitle(),
                    ),
                    Flexible(
                      child: SizedBox(height: availableHeight / 33.4),
                    ),
                    const Flexible(
                      child: MainPageInTrends(),
                    ),
                    Flexible(
                      child: SizedBox(height: availableHeight / 25),
                    ),
                    Flexible(
                      child: BlocBuilder<PlaylistsBloc, PlaylistsState>(
                          builder: (context, state) {
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
                                  height: availableHeight / 4,
                                  color: Colors.white,
                                  child: Center(
                                      child: Text(
                                    LocaleKeys.no_content.tr(),
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp,
                                      color: AppColors.primaryColor
                                    )
                                  ))));
                        }

                        if (state.playlistsStatus == PlaylistsStatus.failure) {
                          return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Container(
                                  width: double.infinity,
                                  height: availableHeight / 4,
                                  color: Colors.white,
                                  child: Center(
                                      child: Text(
                                    LocaleKeys.something_went_wrong.tr(),
                                    style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.sp,
                                          color: AppColors.primaryColor
                                      )
                                  ))));
                        }

                        return PlaylistsMainPage(
                          list: state.list,
                          title: LocaleKeys.playlists.tr(),
                        );
                      }),
                    ),
                    Flexible(
                      child: SizedBox(height: availableHeight / 25),
                    ),
                    Flexible(
                      child: BlocBuilder<GenresBloc, GenresState>(
                          builder: (context, state) {
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
                                  height: availableHeight / 4,
                                  color: Colors.white,
                                  child: Center(
                                      child: Text(
                                    LocaleKeys.no_content.tr(),
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                        color: AppColors.primaryColor
                                    ),
                                  ))));
                        }

                        if (state.genresStatus == GenresStatus.failure) {
                          return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Container(
                                  width: double.infinity,
                                  height: availableHeight / 4,
                                  color: Colors.white,
                                  child: Center(
                                      child: Text(
                                    LocaleKeys.something_went_wrong.tr(),
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                        color: AppColors.primaryColor
                                    ),
                                  ))));
                        }

                        return PlaylistsMainPage(
                          list: state.genresList,
                          title: LocaleKeys.genres.tr(),
                        );
                      }),
                    ),
                    Flexible(
                      child: SizedBox(height: availableHeight / 25),
                    ),
                    Flexible(
                      child: BlocBuilder<CategoriesBloc, CategoriesState>(
                          builder: (context, state) {
                        if (state.categoriesStatus ==
                                CategoriesStatus.loading ||
                            state.categoriesStatus ==
                                CategoriesStatus.initial) {
                          return Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              enabled: true,
                              child: const SingleChildScrollView(
                                physics: NeverScrollableScrollPhysics(),
                                child: MainTilePlaceholder(),
                              ));
                        }

                        if (state.categoriesStatus ==
                                CategoriesStatus.success &&
                            state.categoriesList.isEmpty) {
                          return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Container(
                                  width: double.infinity,
                                  height: availableHeight / 4,
                                  color: Colors.white,
                                  child: Center(
                                      child: Text(
                                    LocaleKeys.no_content.tr(),
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                        color: AppColors.primaryColor
                                    ),
                                  ))));
                        }

                        if (state.categoriesStatus ==
                            CategoriesStatus.failure) {
                          return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Container(
                                  width: double.infinity,
                                  height: availableHeight / 4,
                                  color: Colors.white,
                                  child: Center(
                                      child: Text(
                                    LocaleKeys.something_went_wrong.tr(),
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                        color: AppColors.primaryColor
                                    ),
                                  ))));
                        }

                        return PlaylistsMainPage(
                          list: state.categoriesList,
                          title: LocaleKeys.language_affiliation.tr(),
                        );
                      }),
                    ),
                    Flexible(
                      child: SizedBox(height: availableHeight / 25),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
