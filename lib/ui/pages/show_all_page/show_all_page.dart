import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/data/data.dart';
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
import 'package:muzzone/ui/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

import '../player_page/bloc/audio_bloc.dart';

class ShowAllPage extends StatelessWidget {
  const ShowAllPage({super.key});

  static const id = '/show_all_page';

  @override
  Widget build(BuildContext context) {
    late Bloc bloc;

    final PagingController<int, Track> pagingController =
        PagingController<int, Track>(firstPageKey: 1);

    var initArgs =
        ModalRoute.of(context)!.settings.arguments as ShowAllPageArguments;

    var whichType = initArgs.item is MyPlaylist
        ? 'MyPlaylist'
        : initArgs.item is List<dynamic>
            ? (initArgs.item as List<dynamic>).last is MyPlaylist
                ? 'List<MyPlaylist>'
                : initArgs.item is List<Audio>
                    ? 'List<Audio>'
                    : 'unknown'
            : 'unknown';

    if (whichType == 'MyPlaylist') {
      if ((initArgs.item as MyPlaylist).isGenre) {
        bloc = GenresBloc(backendRepository: GetIt.I.get<BackendRepository>());
      }
      if ((initArgs.item as MyPlaylist).isLanguage) {
        bloc =
            CategoriesBloc(backendRepository: GetIt.I.get<BackendRepository>());
      }
      if ((initArgs.item as MyPlaylist).isAlbum) {
        bloc = AlbumsBloc(backendRepository: GetIt.I.get<BackendRepository>());
      }
      if ((initArgs.item as MyPlaylist).isBackendPlaylist) {
        bloc =
            PlaylistsBloc(backendRepository: GetIt.I.get<BackendRepository>());
      }
    }

    if (whichType == 'List<MyPlaylist>') {
      bloc = GenresBloc(backendRepository: GetIt.I.get<BackendRepository>());
    }

    if (whichType == 'List<Audio>') {
      bloc = PlaylistsBloc(backendRepository: GetIt.I.get<BackendRepository>());
    }

    return whichType == 'MyPlaylist'
        ? MultiBlocProvider(
            providers: [
                if ((initArgs.item as MyPlaylist).isGenre) ...[
                  BlocProvider<GenresBloc>(
                      create: (BuildContext context) => bloc as GenresBloc),
                ],
                if ((initArgs.item as MyPlaylist).isLanguage) ...[
                  BlocProvider<CategoriesBloc>(
                      create: (BuildContext context) => bloc as CategoriesBloc),
                ],
                if ((initArgs.item as MyPlaylist).isAlbum) ...[
                  BlocProvider<AlbumsBloc>(
                      create: (BuildContext context) => bloc as AlbumsBloc)
                ],
                if ((initArgs.item as MyPlaylist).isBackendPlaylist) ...[
                  BlocProvider<PlaylistsBloc>(
                      create: (BuildContext context) => bloc as PlaylistsBloc),
                ],
              ],
            child: MultiBlocListener(
                listeners: [
                  if ((initArgs.item as MyPlaylist).isGenre) ...[
                    BlocListener<GenresBloc, GenresState>(
                        bloc: bloc as GenresBloc,
                        listener: (context, state) {
                          if (state.genreStatus == GenresStatus.success) {
                            con.audios = state.genre.tracks
                                .map((e) => Audio.network(
                                      e.file,
                                      metas: Metas(
                                        id: e.id.toString(),
                                        title: e.name,
                                        artist: e.name,
                                        album: e.name,
                                        extra: {
                                          'isPopular': false,
                                          'isNew': false,
                                        },
                                        image: MetasImage.network(e.cover),
                                      ),
                                    ))
                                .toList();

                            pagingController.appendLastPage(state.tracksList);

                            /*if (state.hasReached) {
                          pagingController.appendLastPage(state.genresList);
                        } else {
                          pagingController.appendPage(
                              state.genresList, state.nextPage);
                        }*/
                          }

                          if (state.genreStatus == GenresStatus.failure) {
                            pagingController.error = "Something went wrong";
                          }
                        }),
                  ],
                  if ((initArgs.item as MyPlaylist).isLanguage) ...[
                    BlocListener<CategoriesBloc, CategoriesState>(
                        bloc: bloc as CategoriesBloc,
                        listener: (context, state) {
                          if (state.categoryStatus ==
                              CategoriesStatus.success) {
                            con.audios = state.category.tracks
                                .map((e) => Audio.network(
                                      e.file,
                                      metas: Metas(
                                        id: e.id.toString(),
                                        title: e.name,
                                        artist: e.name,
                                        album: e.name,
                                        extra: {
                                          'isPopular': false,
                                          'isNew': false,
                                        },
                                        image: MetasImage.network(e.cover),
                                      ),
                                    ))
                                .toList();

                            pagingController.appendLastPage(state.tracksList);

                            /*if (state.hasReached) {
                          pagingController.appendLastPage(state.categoriesList);
                        } else {
                          pagingController.appendPage(
                              state.categoriesList, state.nextPage);
                        }*/
                          }

                          if (state.categoryStatus ==
                              CategoriesStatus.failure) {
                            pagingController.error = "Something went wrong";
                          }
                        }),
                  ],
                  if ((initArgs.item as MyPlaylist).isAlbum) ...[
                    BlocListener<AlbumsBloc, AlbumsState>(
                        bloc: bloc as AlbumsBloc,
                        listener: (context, state) {
                          if (state.albumStatus == AlbumsStatus.success) {
                            con.audios = state.album.tracks
                                .map((e) => Audio.network(
                                      e.file,
                                      metas: Metas(
                                        id: e.id.toString(),
                                        title: e.name,
                                        artist: e.name,
                                        album: e.name,
                                        extra: {
                                          'isPopular': false,
                                          'isNew': false,
                                        },
                                        image: MetasImage.network(e.cover),
                                      ),
                                    ))
                                .toList();

                            pagingController.appendLastPage(state.tracksList);

                            /*if (state.hasReached) {
                          pagingController.appendLastPage(state.albumsList);
                        } else {
                          pagingController.appendPage(
                              state.albumsList, state.nextPage);
                        }*/
                          }

                          if (state.albumStatus == AlbumsStatus.failure) {
                            pagingController.error = "Something went wrong";
                          }
                        }),
                  ],
                  if ((initArgs.item as MyPlaylist).isBackendPlaylist) ...[
                    BlocListener<PlaylistsBloc, PlaylistsState>(
                        bloc: bloc as PlaylistsBloc,
                        listener: (context, state) {
                          if (state.playlistStatus == PlaylistsStatus.success) {
                            con.audios = state.backendPlaylist.tracks
                                .map((e) => Audio.network(
                                      e.file,
                                      metas: Metas(
                                        id: e.id.toString(),
                                        title: e.name,
                                        artist: e.name,
                                        album: e.name,
                                        extra: {
                                          'isPopular': false,
                                          'isNew': false,
                                        },
                                        image: MetasImage.network(e.cover),
                                      ),
                                    ))
                                .toList();

                            pagingController.appendLastPage(state.tracksList);

                            /*if (state.hasReached) {
                          pagingController.appendLastPage(state.list);
                        } else {
                          pagingController.appendPage(
                              state.list, state.nextPage);
                        }*/
                          }

                          if (state.playlistStatus == PlaylistsStatus.failure) {
                            pagingController.error = "Something went wrong";
                          }
                        }),
                  ],
                ],
                child: _ShowAllPage(
                  bloc: bloc,
                  pagingController: pagingController,
                  myPlaylist: (initArgs.item as MyPlaylist),
                  whichType: whichType,
                )))
        : whichType == 'List<MyPlaylist>'
            ? _ShowAllPage(
                bloc: bloc,
                pagingController: pagingController,
                myPlaylist: const MyPlaylist(),
                whichType: whichType,
              )
            : whichType == 'List<Audio>'
                ? BlocProvider(
                    create: (BuildContext context) => PlaylistsBloc(
                        backendRepository: GetIt.I.get<BackendRepository>()),
                    child: BlocListener<PlaylistsBloc, PlaylistsState>(
                        bloc: bloc as PlaylistsBloc,
                        listener: (context, state) {
                          if (state.playlistStatus == PlaylistsStatus.success) {
                            con.audios = state.backendPlaylist.tracks
                                .map((e) => Audio.network(
                                      e.file,
                                      metas: Metas(
                                        id: e.id.toString(),
                                        title: e.name,
                                        artist: e.name,
                                        album: e.name,
                                        extra: {
                                          'isPopular': false,
                                          'isNew': false,
                                        },
                                        image: MetasImage.network(e.cover),
                                      ),
                                    ))
                                .toList();

                            pagingController.appendLastPage(state.tracksList);

                            /*if (state.hasReached) {
                          pagingController.appendLastPage(state.list);
                        } else {
                          pagingController.appendPage(
                              state.list, state.nextPage);
                        }*/
                          }

                          if (state.playlistStatus == PlaylistsStatus.failure) {
                            pagingController.error = "Something went wrong";
                          }
                        },
                        child: _ShowAllPage(
                          bloc: bloc,
                          pagingController: pagingController,
                          myPlaylist: MyPlaylist(
                            id: initArgs.id,
                          ),
                          whichType: whichType,
                        )),
                  )
                : const SizedBox.shrink();
  }
}

class _ShowAllPage extends StatefulWidget {
  const _ShowAllPage(
      {super.key,
      required this.bloc,
      required this.pagingController,
      required this.myPlaylist,
      required this.whichType});

  final Bloc bloc;
  final PagingController<int, Track> pagingController;
  final MyPlaylist myPlaylist;
  final String whichType;

  @override
  State<_ShowAllPage> createState() => _ShowAllPageState();
}

class _ShowAllPageState extends State<_ShowAllPage> {
  final MainController con = GetIt.I.get<MainController>();
  final audioBloc = GetIt.I.get<AudioBloc>();

  @override
  void initState() {
    widget.pagingController.addPageRequestListener((pageKey) {
      if (widget.whichType == 'MyPlaylist') {
        if (widget.myPlaylist.isGenre) {
          widget.bloc.add(GetGenre(genreId: widget.myPlaylist.id.toString()));
        }
        if (widget.myPlaylist.isLanguage) {
          widget.bloc
              .add(GetCategory(categoryId: widget.myPlaylist.id.toString()));
        }
        if (widget.myPlaylist.isAlbum) {
          widget.bloc.add(GetAlbum(albumId: widget.myPlaylist.id.toString()));
        }
        if (widget.myPlaylist.isBackendPlaylist) {
          widget.bloc
              .add(GetPlaylist(playlistId: widget.myPlaylist.id.toString()));
        }
      }

      if (widget.whichType == 'List<Audio>') {
        widget.bloc
            .add(GetPlaylist(playlistId: widget.myPlaylist.id.toString()));
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
    var args =
        ModalRoute.of(context)!.settings.arguments as ShowAllPageArguments;

    var whichType = args.item is MyPlaylist
        ? 'MyPlaylist'
        : args.item is List<dynamic>
            ? (args.item as List<dynamic>).last is MyPlaylist
                ? 'List<MyPlaylist>'
                : args.item is List<Audio>
                    ? 'List<Audio>'
                    : 'unknown'
            : 'unknown';

    return PageLayout(
      children: [
        HeaderTitle(
          title: args.title,
          icon: 'search',
          iconColor: Theme.of(context).cardColor,
        ),
        SizedBox(
          height: 3.h,
        ),
        if (whichType == 'MyPlaylist'
            ? args.item.audios is List<Audio>
            : false) ...[
          SizedBox(
              height: 500,
              child: CustomScrollView(
                slivers: [
                  PagedSliverList<int, Track>(
                    pagingController: widget.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Track>(
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
                        itemBuilder: (context, item, index) => AudioRow(
                              height: 7.h,
                              audio: Audio.network(
                                item.file,
                                metas: Metas(
                                  id: item.id.toString(),
                                  title: item.name,
                                  artist: item.name,
                                  album: item.name,
                                  extra: {
                                    'isPopular': false,
                                    'isNew': false,
                                  },
                                  image: MetasImage.network(item.cover),
                                ),
                              ),
                              onPress: () {
                                con.playSong(con.audios, index);
                                audioBloc.add(StartPlaying(con.audios));
                              },
                            )),
                  )
                ],
              ))

          /*if ((args.item as MyPlaylist).isGenre) ...[
            BlocBuilder<GenresBloc, GenresState>(builder: (context, state) {
              if (state.genreStatus == GenresStatus.loading) {
                return const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primaryColor));
              }

              if (state.genreStatus == GenresStatus.success) {
                if (state.genre.tracks.isEmpty) {
                  return const SizedBox.shrink();
                }

                con.audios = state.genre.tracks
                    .map((e) => Audio.network(
                          e.file,
                          metas: Metas(
                            id: e.id.toString(),
                            title: e.name,
                            artist: e.name,
                            album: e.name,
                            extra: {
                              'isPopular': false,
                              'isNew': false,
                            },
                            image: MetasImage.network(e.cover),
                          ),
                        ))
                    .toList();
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: state.genre.tracks.length,
                itemBuilder: (context, index) => AudioRow(
                  height: 7.h,
                  audio: Audio.network(
                    state.genre.tracks[index].file,
                    metas: Metas(
                      id: state.genre.tracks[index].id.toString(),
                      title: state.genre.tracks[index].name,
                      artist: state.genre.tracks[index].name,
                      album: state.genre.tracks[index].name,
                      extra: {
                        'isPopular': false,
                        'isNew': false,
                      },
                      image:
                          MetasImage.network(state.genre.tracks[index].cover),
                    ),
                  ),
                  onPress: () {
                    con.playSong(con.audios, index);
                    audioBloc.add(StartPlaying(con.audios));
                  },
                ),
              );
            })
          ],
          if ((args.item as MyPlaylist).isLanguage) ...[
            BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
              if (state.categoryStatus == CategoriesStatus.loading) {
                return const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primaryColor));
              }

              if (state.categoryStatus == GenresStatus.success) {
                if (state.category.tracks.isEmpty) {
                  return const SizedBox.shrink();
                }

                con.audios = state.category.tracks
                    .map((e) => Audio.network(
                          e.file,
                          metas: Metas(
                            id: e.id.toString(),
                            title: e.name,
                            artist: e.name,
                            album: e.name,
                            extra: {
                              'isPopular': false,
                              'isNew': false,
                            },
                            image: MetasImage.network(e.cover),
                          ),
                        ))
                    .toList();
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: state.category.tracks.length,
                itemBuilder: (context, index) => AudioRow(
                  height: 7.h,
                  audio: Audio.network(
                    state.category.tracks[index].file,
                    metas: Metas(
                      id: state.category.tracks[index].id.toString(),
                      title: state.category.tracks[index].name,
                      artist: state.category.tracks[index].name,
                      album: state.category.tracks[index].name,
                      extra: {
                        'isPopular': false,
                        'isNew': false,
                      },
                      image: MetasImage.network(
                          state.category.tracks[index].cover),
                    ),
                  ),
                  onPress: () {
                    con.playSong(con.audios, index);
                    audioBloc.add(StartPlaying(con.audios));
                  },
                ),
              );
            }),
          ],
          if ((args.item as MyPlaylist).isAlbum) ...[
            BlocBuilder<AlbumsBloc, AlbumsState>(builder: (context, state) {
              if (state.albumStatus == AlbumsStatus.loading) {
                return const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primaryColor));
              }

              if (state.albumStatus == GenresStatus.success) {
                if (state.album.tracks.isEmpty) {
                  return const SizedBox.shrink();
                }

                con.audios = state.album.tracks
                    .map((e) => Audio.network(
                          e.file,
                          metas: Metas(
                            id: e.id.toString(),
                            title: e.name,
                            artist: e.name,
                            album: e.name,
                            extra: {
                              'isPopular': false,
                              'isNew': false,
                            },
                            image: MetasImage.network(e.cover),
                          ),
                        ))
                    .toList();
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: state.album.tracks.length,
                itemBuilder: (context, index) => AudioRow(
                  height: 7.h,
                  audio: Audio.network(
                    state.album.tracks[index].file,
                    metas: Metas(
                      id: state.album.tracks[index].id.toString(),
                      title: state.album.tracks[index].name,
                      artist: state.album.tracks[index].name,
                      album: state.album.tracks[index].name,
                      extra: {
                        'isPopular': false,
                        'isNew': false,
                      },
                      image:
                          MetasImage.network(state.album.tracks[index].cover),
                    ),
                  ),
                  onPress: () {
                    con.playSong(con.audios, index);
                    audioBloc.add(StartPlaying(con.audios));
                  },
                ),
              );
            }),
          ],
          if ((args.item as MyPlaylist).isBackendPlaylist) ...[
            BlocBuilder<PlaylistsBloc, PlaylistsState>(
                builder: (context, state) {
              if (state.playlistStatus == PlaylistsStatus.loading) {
                return const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primaryColor));
              }

              if (state.playlistStatus == PlaylistsStatus.success) {
                if (state.backendPlaylist.tracks.isEmpty) {
                  return const SizedBox.shrink();
                }

                con.audios = state.backendPlaylist.tracks
                    .map((e) => Audio.network(
                          e.file,
                          metas: Metas(
                            id: e.id.toString(),
                            title: e.name,
                            artist: e.name,
                            album: e.name,
                            extra: {
                              'isPopular': false,
                              'isNew': false,
                            },
                            image: MetasImage.network(e.cover),
                          ),
                        ))
                    .toList();
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: state.backendPlaylist.tracks.length,
                itemBuilder: (context, index) => AudioRow(
                  height: 7.h,
                  audio: Audio.network(
                    state.backendPlaylist.tracks[index].file,
                    metas: Metas(
                      id: state.backendPlaylist.tracks[index].id.toString(),
                      title: state.backendPlaylist.tracks[index].name,
                      artist: state.backendPlaylist.tracks[index].name,
                      album: state.backendPlaylist.tracks[index].name,
                      extra: {
                        'isPopular': false,
                        'isNew': false,
                      },
                      image: MetasImage.network(
                          state.backendPlaylist.tracks[index].cover),
                    ),
                  ),
                  onPress: () {
                    con.playSong(con.audios, index);
                    audioBloc.add(StartPlaying(con.audios));
                  },
                ),
              );
            }),
          ],*/
        ] else if (whichType == 'List<Audio>') ...[
          SizedBox(
              height: 500,
              child: CustomScrollView(
                slivers: [
                  PagedSliverList<int, Track>(
                    pagingController: widget.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Track>(
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
                        itemBuilder: (context, item, index) => AudioRow(
                              height: 7.h,
                              audio: Audio.network(
                                item.file,
                                metas: Metas(
                                  id: item.id.toString(),
                                  title: item.name,
                                  artist: item.name,
                                  album: item.name,
                                  extra: {
                                    'isPopular': false,
                                    'isNew': false,
                                  },
                                  image: MetasImage.network(item.cover),
                                ),
                              ),
                              onPress: () {
                                con.playSong(con.audios, index);
                                audioBloc.add(StartPlaying(con.audios));
                              },
                            )),
                  )
                ],
              ))

          /*BlocBuilder<PlaylistsBloc, PlaylistsState>(builder: (context, state) {
            if (state.playlistStatus == PlaylistsStatus.loading) {
              return const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primaryColor));
            }

            if (state.playlistStatus == PlaylistsStatus.success) {
              if (state.backendPlaylist.tracks.isEmpty) {
                return const SizedBox.shrink();
              }

              con.audios = state.backendPlaylist.tracks
                  .map((e) => Audio.network(
                        e.file,
                        metas: Metas(
                          id: e.id.toString(),
                          title: e.name,
                          artist: e.name,
                          album: e.name,
                          extra: {
                            'isPopular': false,
                            'isNew': false,
                          },
                          image: MetasImage.network(e.cover),
                        ),
                      ))
                  .toList();
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: state.backendPlaylist.tracks.length,
              itemBuilder: (context, index) => AudioRow(
                height: 7.h,
                audio: Audio.network(
                  state.backendPlaylist.tracks[index].file,
                  metas: Metas(
                    id: state.backendPlaylist.tracks[index].id.toString(),
                    title: state.backendPlaylist.tracks[index].name,
                    artist: state.backendPlaylist.tracks[index].name,
                    album: state.backendPlaylist.tracks[index].name,
                    extra: {
                      'isPopular': false,
                      'isNew': false,
                    },
                    image: MetasImage.network(
                        state.backendPlaylist.tracks[index].cover),
                  ),
                ),
                onPress: () {
                  con.playSong(con.audios, index);
                  audioBloc.add(StartPlaying(con.audios));
                },
              ),
            );
          }),*/
        ] else if (whichType ==
            'List<MyPlaylist>' /* ||
            args.fromPage != 'my_music_playlists'*/
        ) ...[
          PlaylistsWrap(
              fromPage: 'show_all_page',
              item: (args.item! as List<MyPlaylist>),
              pagingController: PagingController<int, MyPlaylist>(
                firstPageKey: 1,
              ))
        ],
        /*if (args.item[0] is Audio)
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: args.item.length,
            itemBuilder: (context, index) => AudioRow(
              height: 7.h,
              audio: args.item[index],
              onPress: () {
                con.playSong(con.audios, index);
                audioBloc.add(StartPlaying(con.audios));
              },
            ),
          )
        else if (args.fromPage != 'my_music_playlists')
          PlaylistsWrap(
            fromPage: 'show_all_page',
            item: args.item,
          ),*/
      ],
    );
  }
}
