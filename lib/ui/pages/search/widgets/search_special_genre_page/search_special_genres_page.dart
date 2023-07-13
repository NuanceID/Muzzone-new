import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/data/repositories/remote_repositories/backend_repository.dart';
import 'package:muzzone/logic/blocs/genres/genres_bloc.dart';
import 'package:muzzone/logic/blocs/genres/genres_event.dart';
import 'package:muzzone/logic/blocs/genres/genres_state.dart';
import 'package:muzzone/ui/widgets/layout_widgets/header_title.dart';

import '../../../../../generated/locale_keys.g.dart';
import '../search_chosen_genre_page/search_chosen_genre_page.dart';

class SearchSpecialGenresPage extends StatelessWidget {
  const SearchSpecialGenresPage({super.key});

  static const id = 'SearchSpecialGenresPage';

  @override
  Widget build(BuildContext context) {
    Bloc bloc = GenresBloc(backendRepository: context.read<BackendRepository>());
    PagingController<int, MyPlaylist> pagingController =
    PagingController<int, MyPlaylist>(firstPageKey: 1);

    return BlocProvider<GenresBloc>(
        create: (BuildContext context) => bloc,
        child: BlocListener<GenresBloc, GenresState>(
            bloc: bloc as GenresBloc,
            listener: (context, state) {
              if (state.genresStatus == GenresStatus.success) {
                if (state.hasReached) {
                  pagingController.appendLastPage(state.genresList);
                } else {
                  pagingController.appendPage(state.genresList, state.nextPage);
                }
              }

              if (state.genresStatus == GenresStatus.failure) {
                pagingController.error = "Something went wrong";
              }
            },
            child: _SearchSpecialGenresPage(
                pagingController: pagingController, bloc: bloc)));
  }
}

class _SearchSpecialGenresPage extends StatefulWidget {
  const _SearchSpecialGenresPage(
      {Key? key, required this.pagingController, required this.bloc})
      : super(key: key);

  final PagingController<int, MyPlaylist> pagingController;
  final Bloc bloc;

  @override
  State<_SearchSpecialGenresPage> createState() =>
      _SearchSpecialGenresPageState();
}

class _SearchSpecialGenresPageState extends State<_SearchSpecialGenresPage> {
  //final List<MyPlaylist> allGenres = [];

  @override
  void initState() {
    /*for (var genre in LocalPlaylistsRepository.localPlaylists) {
      if (genre.isGenre == true) {
        allGenres.add(genre);
      }
    }*/
    widget.pagingController.addPageRequestListener((pageKey) {
      widget.bloc.add(GetMoreGenres(page: pageKey.toString()));
    });

    super.initState();
  }

  @override
  void dispose() {
    widget.pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      height: availableHeight-120,
      width: double.infinity,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: HeaderTitle(
              title: LocaleKeys.genres.tr(),
            ),
          ),
          PagedSliverList<int, MyPlaylist>(
            pagingController: widget.pagingController,
            builderDelegate: PagedChildBuilderDelegate<MyPlaylist>(
                noItemsFoundIndicatorBuilder: (_) => Text(
                  LocaleKeys.no_content.tr(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                firstPageErrorIndicatorBuilder: (_) => Text(
                  LocaleKeys.something_went_wrong.tr(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                newPageErrorIndicatorBuilder: (_) => Text(
                  LocaleKeys.something_went_wrong.tr(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                itemBuilder: (context, item, index) =>
                    SearchSpecialGenresListTile(
                      genre: item,
                    )),
          )
        ],
      ),
    );
  }

/*@override
  Widget build(BuildContext context) {
    return PageLayout(
      needAnotherBottomHeight: true,
      children: [
        HeaderTitle(
          title: LocaleKeys.genres.tr(),
        ),
        ListView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: allGenres.length,
          itemBuilder: (context, index) =>
              SearchSpecialGenresListTile(allGenres: allGenres, index: index),
        ),
      ],
    );
  }*/
}

class SearchSpecialGenresListTile extends StatelessWidget {
  const SearchSpecialGenresListTile({
    Key? key,
    /*required this.allGenres,*/ required this.genre,
    /*required this.index*/
  }) : super(key: key);

  //final List<MyPlaylist> allGenres;
  final MyPlaylist genre;

  //final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          SearchChosenGenrePage.id,
          arguments:
          PageWithPlaylistArgument(playlist: genre //allGenres[index],
          ),
        );
      },
      visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
      contentPadding: EdgeInsets.symmetric(horizontal: 7.w),
      title: Text(
        genre.title, //allGenres[index].title,
        style: TextStyle(
          fontSize: 15.sp,
        ),
        textAlign: TextAlign.left,
      ),
      trailing: SvgPicture.asset(
        '${iconsPath}arrow.svg',
      ),
    );
  }
}
