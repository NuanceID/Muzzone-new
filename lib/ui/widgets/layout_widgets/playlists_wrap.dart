import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:muzzone/config/path/path.dart';
import 'package:muzzone/config/style/style.dart';
import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/data/repositories/remote_repositories/backend_repository.dart';
import 'package:muzzone/generated/locale_keys.g.dart';
import 'package:muzzone/logic/blocs/albums/albums_bloc.dart';
import 'package:muzzone/logic/blocs/albums/albums_event.dart';
import 'package:muzzone/logic/blocs/albums/albums_state.dart';
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
import 'package:sizer/sizer.dart';

import '../../../config/routes/arguments/album_page_arguments.dart';
import '../../../config/routes/arguments/page_with_playlists_argument.dart';
import '../../pages/album/view/album_page.dart';
import '../../pages/search/widgets/search_chosen_genre_page/search_chosen_genre_page.dart';
import '../../pages/search/widgets/search_special_genre_page/search_special_genres_page.dart';

class PlaylistsWrap extends StatelessWidget {
  const PlaylistsWrap(
      {Key? key,
      required this.item,
      required this.fromPage,
      required this.pagingController})
      : super(key: key);

  final List<MyPlaylist> item;
  final String fromPage;
  final PagingController<int, MyPlaylist> pagingController;

  @override
  Widget build(BuildContext context) {
    late Bloc bloc;

    if (item.last.isGenre) {
      bloc = GenresBloc(backendRepository: GetIt.I.get<BackendRepository>());
    }
    if (item.last.isLanguage) {
      bloc =
          CategoriesBloc(backendRepository: GetIt.I.get<BackendRepository>());
    }
    if (item.last.isAlbum) {
      bloc = AlbumsBloc(backendRepository: GetIt.I.get<BackendRepository>());
    }
    if (item.last.isBackendPlaylist) {
      bloc = PlaylistsBloc(backendRepository: GetIt.I.get<BackendRepository>());
    }

    return MultiBlocProvider(
        providers: [
          if (item.last.isGenre) ...[
            BlocProvider<GenresBloc>(
                create: (BuildContext context) => bloc as GenresBloc),
          ],
          if (item.last.isLanguage) ...[
            BlocProvider<CategoriesBloc>(
                create: (BuildContext context) => bloc as CategoriesBloc),
          ],
          if (item.last.isAlbum) ...[
            BlocProvider<AlbumsBloc>(
                create: (BuildContext context) => bloc as AlbumsBloc)
          ],
          if (item.last.isBackendPlaylist) ...[
            BlocProvider<PlaylistsBloc>(
                create: (BuildContext context) => bloc as PlaylistsBloc)
          ],
        ],
        child: MultiBlocListener(
            listeners: [
              if (item.last.isGenre) ...[
                BlocListener<GenresBloc, GenresState>(
                    bloc: bloc as GenresBloc,
                    listener: (context, state) {
                      if (state.genresStatus == GenresStatus.success) {
                        if (state.hasReached) {
                          pagingController.appendLastPage(state.genresList);
                        } else {
                          pagingController.appendPage(
                              state.genresList, state.nextPage);
                        }
                      }

                      if (state.genresStatus == GenresStatus.failure) {
                        pagingController.error = "Something went wrong";
                      }
                    }),
              ],
              if (item.last.isLanguage) ...[
                BlocListener<CategoriesBloc, CategoriesState>(
                    bloc: bloc as CategoriesBloc,
                    listener: (context, state) {
                      if (state.categoriesStatus == CategoriesStatus.success) {
                        if (state.hasReached) {
                          pagingController.appendLastPage(state.categoriesList);
                        } else {
                          pagingController.appendPage(
                              state.categoriesList, state.nextPage);
                        }
                      }

                      if (state.categoriesStatus == CategoriesStatus.failure) {
                        pagingController.error = "Something went wrong";
                      }
                    }),
              ],
              if (item.last.isAlbum) ...[
                BlocListener<AlbumsBloc, AlbumsState>(
                    bloc: bloc as AlbumsBloc,
                    listener: (context, state) {
                      if (state.albumsStatus == AlbumsStatus.success) {
                        if (state.hasReached) {
                          pagingController.appendLastPage(state.albumsList);
                        } else {
                          pagingController.appendPage(
                              state.albumsList, state.nextPage);
                        }
                      }

                      if (state.albumsStatus == AlbumsStatus.failure) {
                        pagingController.error = "Something went wrong";
                      }
                    }),
              ],
              if (item.last.isBackendPlaylist) ...[
                BlocListener<PlaylistsBloc, PlaylistsState>(
                    bloc: bloc as PlaylistsBloc,
                    listener: (context, state) {
                      if (state.playlistsStatus == PlaylistsStatus.success) {
                        if (state.hasReached) {
                          pagingController.appendLastPage(state.list);
                        } else {
                          pagingController.appendPage(
                              state.list, state.nextPage);
                        }
                      }

                      if (state.playlistsStatus == PlaylistsStatus.failure) {
                        pagingController.error = "Something went wrong";
                      }
                    }),
              ],
            ],
            child: _PlaylistsWrap(
                item: item,
                fromPage: fromPage,
                pagingController: pagingController,
                bloc: bloc)));
  }
}

class _PlaylistsWrap extends StatefulWidget {
  const _PlaylistsWrap(
      {super.key,
      required this.item,
      required this.fromPage,
      required this.pagingController,
      required this.bloc});

  final List<MyPlaylist> item;
  final String fromPage;
  final PagingController<int, MyPlaylist> pagingController;
  final Bloc bloc;

  @override
  State<_PlaylistsWrap> createState() => _PlaylistsWrapState();
}

class _PlaylistsWrapState extends State<_PlaylistsWrap> {
  final con = GetIt.I.get<MainController>();

  @override
  void initState() {
    widget.pagingController.addPageRequestListener((pageKey) {
      if (widget.item.last.isGenre) {
        widget.bloc.add(GetMoreGenres(page: pageKey.toString()));
      }
      if (widget.item.last.isLanguage) {
        widget.bloc.add(GetMoreCategories(page: pageKey.toString()));
      }
      if (widget.item.last.isAlbum) {
        widget.bloc.add(GetMoreAlbums(page: pageKey.toString()));
      }
      if (widget.item.last.isBackendPlaylist) {
        widget.bloc.add(GetMorePlaylists(page: pageKey.toString()));
      }
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
    return Padding(
        padding: EdgeInsets.only(left: 7.w, right: 7.w, bottom: 3.h),
        child: SizedBox(
          height: 60.h,
          child: CustomScrollView(
            slivers: [
              if (widget.item.last.isGenre) ...[
                SliverToBoxAdapter(
                  child: GestureDetector(
                    onTap: () async => goNextPage(
                      context,
                      const MyPlaylist(
                          title: 'По жанру',
                          image: '${imagesMainPagePath}111.png'),
                    ),
                    child: Container(
                      height: (86.w - 5.w) / 2,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('${imagesMainPagePath}111.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: Text(
                          'По жанру',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 3.h,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                    child: SizedBox(
                  height: 10,
                )),
              ],
              PagedSliverGrid<int, MyPlaylist>(
                pagingController: widget.pagingController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 3.2.w,
                  mainAxisSpacing: 1.5.h,
                  crossAxisCount: 2,
                ),
                builderDelegate: PagedChildBuilderDelegate<MyPlaylist>(
                  noItemsFoundIndicatorBuilder: (_) => Center(
                      child: Text(
                    LocaleKeys.no_content.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  )),
                  firstPageErrorIndicatorBuilder: (_) => Center(
                      child: Text(
                    LocaleKeys.something_went_wrong.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  )),
                  newPageErrorIndicatorBuilder: (_) => Center(
                      child: Text(
                    LocaleKeys.something_went_wrong.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  )),
                  itemBuilder: (context, item, index) => GestureDetector(
                    onTap: () async => goNextPage(context, item),
                    child: Container(
                      width: (86.w - 5.w) / 2,
                      height: (86.w - 5.w) / 2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(item.image),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: Text(
                          item.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 3.h,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Future<void> goNextPage(BuildContext context, MyPlaylist playlist) async {
    if (playlist.title == 'По жанру') {
      await Navigator.of(context).pushNamed(SearchSpecialGenresPage.id);
    } else if (widget.fromPage == 'show_all_page') {
      print('LOG_TAG I AM HERE goNextPage ');
      await Navigator.of(context).pushNamed(AlbumPage.id,
          arguments: AlbumPageArguments(item: playlist, album: playlist.audios));
    } else {
      print('LOG_TAG I AM HERE goNextPage 1 ');
      await Navigator.of(context).pushNamed(SearchChosenGenrePage.id,
          arguments: PageWithPlaylistArgument(playlist: playlist));
    }
  }

/*Future<void> goNextPage(BuildContext context, playlist, index) async {
    if (playlist.title == 'По жанру') {
      await Navigator.of(context).pushNamed(SearchSpecialGenresPage.id);
    } else if (widget.fromPage == 'show_all_page') {
      await Navigator.of(context).pushNamed(AlbumPage.id,
          arguments: AlbumPageArguments(album: con.audios));
    } else {
      await Navigator.of(context).pushNamed(SearchChosenGenrePage.id,
          arguments: PageWithPlaylistArgument(playlist: playlist));
    }
  }*/
}
