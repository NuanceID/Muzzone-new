import 'package:audio_service/audio_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:muzzone/config/config.dart';
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
import 'package:muzzone/logic/blocs/sliding_up_panel/sliding_up_panel_bloc.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel/sliding_up_panel_event.dart';
import 'package:muzzone/main.dart';
import 'package:muzzone/ui/widgets/widgets.dart';

class ShowAllPage extends StatelessWidget {
  const ShowAllPage({super.key});

  static const id = '/show_all_page';

  @override
  Widget build(BuildContext context) {
    late Bloc bloc;

    final PagingController<int, MediaItem> pagingController =
        PagingController<int, MediaItem>(firstPageKey: 1);

    var initArgs =
        ModalRoute.of(context)!.settings.arguments as ShowAllPageArguments;

    var whichType = initArgs.item is MyPlaylist
        ? 'MyPlaylist'
        : initArgs.item is List<dynamic>
            ? (initArgs.item as List<dynamic>).isNotEmpty
                ? (initArgs.item as List<dynamic>).last is MyPlaylist
                    ? 'List<MyPlaylist>'
                    : initArgs.item is List<MediaItem>
                        ? 'List<Audio>'
                        : 'unknown'
                : 'unknown'
            : 'emptyList';

    if (whichType == 'MyPlaylist') {
      if ((initArgs.item as MyPlaylist).isMyPlayList) {
        whichType = 'MyPlaylistFromMyMedia';
      } else {
        if ((initArgs.item as MyPlaylist).isGenre) {
          bloc =
              GenresBloc(backendRepository: context.read<BackendRepository>());
        }
        if ((initArgs.item as MyPlaylist).isLanguage) {
          bloc = CategoriesBloc(
              backendRepository: context.read<BackendRepository>());
        }
        if ((initArgs.item as MyPlaylist).isAlbum) {
          bloc =
              AlbumsBloc(backendRepository: context.read<BackendRepository>());
        }
        if ((initArgs.item as MyPlaylist).isBackendPlaylist) {
          bloc = PlaylistsBloc(
              backendRepository: context.read<BackendRepository>());
        }
      }
    }

    if (whichType == 'List<MyPlaylist>') {
      bloc = GenresBloc(backendRepository: context.read<BackendRepository>());
    }

    if (whichType == 'List<Audio>') {
      if (initArgs.fromPage == 'my_media') {
        whichType = 'List<Audio>_from_my_media';
      } else {
        bloc =
            PlaylistsBloc(backendRepository: context.read<BackendRepository>());
      }
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
                        listener: (context, state) async {
                          if (state.genreStatus == GenresStatus.success) {
                            var playlist = state.genre.tracks
                                .map((e) => MediaItem(
                                      id: e.file,
                                      title: e.name,
                                      album: e.album.name,
                                      artist: e.artists
                                          .map((element) => element.name)
                                          .toList()
                                          .join(', '),
                                      artUri: Uri.parse(e.cover),
                                    ))
                                .toList();

                            pagingController.appendLastPage(playlist);
                          }

                          if (state.genreStatus == GenresStatus.failure) {
                            pagingController.error = "Something went wrong";
                          }
                        }),
                  ],
                  if ((initArgs.item as MyPlaylist).isLanguage) ...[
                    BlocListener<CategoriesBloc, CategoriesState>(
                        bloc: bloc as CategoriesBloc,
                        listener: (context, state) async {
                          if (state.categoryStatus ==
                              CategoriesStatus.success) {
                            var playlist = state.category.tracks
                                .map((e) => MediaItem(
                                      id: e.file,
                                      title: e.name,
                                      album: e.album.name,
                                      artist: e.artists
                                          .map((element) => element.name)
                                          .toList()
                                          .join(', '),
                                      artUri: Uri.parse(e.cover),
                                    ))
                                .toList();

                            pagingController.appendLastPage(playlist);
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
                        listener: (context, state) async {
                          if (state.albumStatus == AlbumsStatus.success) {
                            var playlist = state.album.tracks
                                .map((e) => MediaItem(
                                      id: e.file,
                                      title: e.name,
                                      album: e.album.name,
                                      artist: e.artists
                                          .map((element) => element.name)
                                          .toList()
                                          .join(', '),
                                      artUri: Uri.parse(e.cover),
                                    ))
                                .toList();

                            pagingController.appendLastPage(playlist);
                          }

                          if (state.albumStatus == AlbumsStatus.failure) {
                            pagingController.error = "Something went wrong";
                          }
                        }),
                  ],
                  if ((initArgs.item as MyPlaylist).isBackendPlaylist) ...[
                    BlocListener<PlaylistsBloc, PlaylistsState>(
                        bloc: bloc as PlaylistsBloc,
                        listener: (context, state) async {
                          if (state.playlistStatus == PlaylistsStatus.success) {
                            var playlist = state.backendPlaylist.tracks
                                .map((e) => MediaItem(
                                      id: e.file,
                                      title: e.name,
                                      album: e.album.name,
                                      artist: e.artists
                                          .map((element) => element.name)
                                          .toList()
                                          .join(', '),
                                      artUri: Uri.parse(e.cover),
                                    ))
                                .toList();

                            pagingController.appendLastPage(playlist);
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
        : whichType == 'MyPlaylistFromMyMedia'
            ? _ShowAllPage(
                pagingController: pagingController,
                myPlaylist: (initArgs.item as MyPlaylist),
                whichType: whichType,
              )
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
                            backendRepository:
                                context.read<BackendRepository>()),
                        child: BlocListener<PlaylistsBloc, PlaylistsState>(
                            bloc: bloc as PlaylistsBloc,
                            listener: (context, state) async {
                              if (state.playlistStatus ==
                                  PlaylistsStatus.success) {
                                var playlist = state.backendPlaylist.tracks
                                    .map((e) => MediaItem(
                                          id: e.file,
                                          title: e.name,
                                          album: e.album.name,
                                          artist: e.artists
                                              .map((element) => element.name)
                                              .toList()
                                              .join(', '),
                                          artUri: Uri.parse(e.cover),
                                        ))
                                    .toList();

                                pagingController.appendLastPage(playlist);
                              }

                              if (state.playlistStatus ==
                                  PlaylistsStatus.failure) {
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
                    : whichType == 'List<Audio>_from_my_media'
                        ? _ShowAllPage(
                            pagingController: pagingController,
                            whichType: whichType,
                          )
                        : const SizedBox.shrink();
  }
}

class _ShowAllPage extends StatefulWidget {
  const _ShowAllPage({
    this.bloc,
    required this.pagingController,
    this.myPlaylist,
    required this.whichType,
  });

  final Bloc? bloc;
  final PagingController<int, MediaItem> pagingController;
  final MyPlaylist? myPlaylist;
  final String whichType;

  @override
  State<_ShowAllPage> createState() => _ShowAllPageState();
}

class _ShowAllPageState extends State<_ShowAllPage> {
  @override
  void initState() {
    super.initState();
    widget.pagingController.addPageRequestListener((pageKey) {
      if (widget.whichType == 'MyPlaylist') {
        if (widget.myPlaylist != null) {
          if (widget.myPlaylist!.isGenre) {
            widget.bloc!
                .add(GetGenre(genreId: widget.myPlaylist!.id.toString()));
          }
          if (widget.myPlaylist!.isLanguage) {
            widget.bloc!
                .add(GetCategory(categoryId: widget.myPlaylist!.id.toString()));
          }
          if (widget.myPlaylist!.isAlbum) {
            widget.bloc!
                .add(GetAlbum(albumId: widget.myPlaylist!.id.toString()));
          }
          if (widget.myPlaylist!.isBackendPlaylist) {
            widget.bloc!
                .add(GetPlaylist(playlistId: widget.myPlaylist!.id.toString()));
          }
        }
      }

      if (widget.whichType == 'List<Audio>') {
        if (widget.myPlaylist != null) {
          widget.bloc!
              .add(GetPlaylist(playlistId: widget.myPlaylist!.id.toString()));
        }
      }
    });
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
                : args.item is List<MediaItem>
                    ? 'List<Audio>'
                    : 'unknown'
            : 'unknown';

    if (whichType == 'MyPlaylist') {
      if ((args.item as MyPlaylist).isMyPlayList) {
        whichType = 'MyPlaylistFromMyMedia';
      }
    }

    if (whichType == 'List<Audio>') {
      if (args.fromPage == 'my_media') {
        whichType = 'List<Audio>_from_my_media';
      }
    }

    return Container(
        color: Colors.white,
        child: Column(
          children: [
            HeaderTitle(
              title: args.title,
              icon: 'search',
              iconColor: Theme.of(context).cardColor,
            ),
            if (whichType == 'List<Audio>_from_my_media'
                ? args.item is List<MediaItem>
                : false) ...[
              Flexible(
                  child: (args.item as List<MediaItem>).isEmpty
                      ? Center(
                          child: Text(
                          LocaleKeys.no_content.tr(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                              color: AppColors.primaryColor),
                        ))
                      : ListView.builder(
                          itemCount: (args.item as List<MediaItem>).length,
                          itemBuilder: (context, index) {
                            if (index ==
                                ((args.item as List<MediaItem>).length - 1)) {
                              return Container(
                                  margin: EdgeInsets.only(
                                      bottom: availableHeight / 25),
                                  child: AudioRow(
                                    audio:
                                        (args.item as List<MediaItem>)[index],
                                    onPress: () async {
                                      await audioHandler
                                          .updateQueue(<MediaItem>[]);

                                      await audioHandler.addQueueItems(([
                                        (args.item as List<MediaItem>)[index]
                                      ]));

                                      if (mounted) {
                                        BlocProvider.of<SlidingUpPanelBloc>(
                                                context)
                                            .add(OpenMiniPlayer());
                                      }
                                      await audioHandler.playFromMediaId(
                                          (args.item as List<MediaItem>)[index]
                                              .id);
                                    },
                                  ));
                            }

                            return AudioRow(
                              audio: (args.item as List<MediaItem>)[index],
                              onPress: () async {
                                await audioHandler.updateQueue(<MediaItem>[]);

                                await audioHandler.addQueueItems(
                                    ([(args.item as List<MediaItem>)[index]]));

                                if (mounted) {
                                  BlocProvider.of<SlidingUpPanelBloc>(context)
                                      .add(OpenMiniPlayer());
                                }
                                await audioHandler.playFromMediaId(
                                    (args.item as List<MediaItem>)[index].id);
                              },
                            );
                          }))
            ] else if (whichType == 'MyPlaylistFromMyMedia'
                ? args.item.audios is List<MediaItem>
                : false) ...[
              Flexible(
                  child: (args.item as MyPlaylist).audios.isEmpty
                      ? Center(
                          child: Text(
                          LocaleKeys.no_content.tr(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                              color: AppColors.primaryColor),
                        ))
                      : ListView.builder(
                          itemCount: (args.item as MyPlaylist).audios.length,
                          itemBuilder: (context, index) {
                            if (index ==
                                ((args.item as MyPlaylist).audios.length - 1)) {
                              return Container(
                                  margin: EdgeInsets.only(
                                      bottom: availableHeight / 25),
                                  child: AudioRow(
                                    audio:
                                        (args.item as MyPlaylist).audios[index],
                                    onPress: () async {
                                      await audioHandler
                                          .updateQueue(<MediaItem>[]);

                                      await audioHandler.addQueueItems(
                                          (args.item as MyPlaylist).audios);
                                      if (mounted) {
                                        BlocProvider.of<SlidingUpPanelBloc>(
                                                context)
                                            .add(OpenMiniPlayer());
                                      }
                                      await audioHandler.playFromMediaId(
                                          (args.item as MyPlaylist)
                                              .audios[index]
                                              .id);
                                    },
                                  ));
                            }

                            return AudioRow(
                              audio: (args.item as MyPlaylist).audios[index],
                              onPress: () async {
                                await audioHandler.updateQueue(<MediaItem>[]);

                                await audioHandler.addQueueItems(
                                    (args.item as MyPlaylist).audios);

                                if (mounted) {
                                  BlocProvider.of<SlidingUpPanelBloc>(context)
                                      .add(OpenMiniPlayer());
                                }

                                await audioHandler.playFromMediaId(
                                    (args.item as MyPlaylist).audios[index].id);
                              },
                            );
                          }))
            ] else if (whichType == 'MyPlaylist'
                ? args.item.audios is List<MediaItem>
                : false) ...[
              Flexible(
                  child: CustomScrollView(
                slivers: [
                  PagedSliverList<int, MediaItem>(
                    pagingController: widget.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<MediaItem>(
                        noItemsFoundIndicatorBuilder: (_) {
                      return Center(
                          child: Text(
                        LocaleKeys.no_content.tr(),
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                            color: AppColors.primaryColor),
                      ));
                    }, firstPageErrorIndicatorBuilder: (_) {
                      return Center(
                          child: Text(
                        LocaleKeys.something_went_wrong.tr(),
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                            color: AppColors.primaryColor),
                      ));
                    }, newPageErrorIndicatorBuilder: (_) {
                      return Center(
                          child: Text(
                        LocaleKeys.something_went_wrong.tr(),
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                            color: AppColors.primaryColor),
                      ));
                    }, itemBuilder: (context, item, index) {
                      widget.pagingController.itemList?.length;

                      if (widget.pagingController.itemList != null) {
                        if (index ==
                            (widget.pagingController.itemList!.length - 1)) {
                          return Container(
                              margin:
                                  EdgeInsets.only(bottom: availableHeight / 25),
                              child: AudioRow(
                                audio: item,
                                onPress: () async {
                                  await audioHandler.updateQueue(<MediaItem>[]);
                                  if (widget.pagingController.itemList !=
                                      null) {
                                    if (widget.pagingController.itemList!
                                        .isNotEmpty) {
                                      await audioHandler.addQueueItems(
                                          widget.pagingController.itemList!);
                                    }
                                  }
                                  if (mounted) {
                                    BlocProvider.of<SlidingUpPanelBloc>(context)
                                        .add(OpenMiniPlayer());
                                  }
                                  await audioHandler.playFromMediaId(item.id);
                                },
                              ));
                        }
                      }

                      return AudioRow(
                        audio: item,
                        onPress: () async {
                          await audioHandler.updateQueue(<MediaItem>[]);
                          if (widget.pagingController.itemList != null) {
                            if (widget.pagingController.itemList!.isNotEmpty) {
                              await audioHandler.addQueueItems(
                                  widget.pagingController.itemList!);
                            }
                          }
                          if (mounted) {
                            BlocProvider.of<SlidingUpPanelBloc>(context)
                                .add(OpenMiniPlayer());
                          }
                          await audioHandler.playFromMediaId(item.id);
                        },
                      );
                    }),
                  )
                ],
              ))
            ] else if (whichType == 'List<Audio>') ...[
              Flexible(
                  child: CustomScrollView(
                slivers: [
                  PagedSliverList<int, MediaItem>(
                    pagingController: widget.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<MediaItem>(
                        noItemsFoundIndicatorBuilder: (_) => Center(
                                child: Text(
                              LocaleKeys.no_content.tr(),
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                  color: AppColors.primaryColor),
                            )),
                        firstPageErrorIndicatorBuilder: (_) => Center(
                                child: Text(
                              LocaleKeys.something_went_wrong.tr(),
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                  color: AppColors.primaryColor),
                            )),
                        newPageErrorIndicatorBuilder: (_) => Center(
                                child: Text(
                              LocaleKeys.something_went_wrong.tr(),
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                  color: AppColors.primaryColor),
                            )),
                        itemBuilder: (context, item, index) => AudioRow(
                              audio: item,
                              onPress: () async {
                                await audioHandler.updateQueue(<MediaItem>[]);
                                if (widget.pagingController.itemList != null) {
                                  if (widget
                                      .pagingController.itemList!.isNotEmpty) {
                                    await audioHandler.addQueueItems(
                                        widget.pagingController.itemList!);
                                  }
                                }
                                if (mounted) {
                                  BlocProvider.of<SlidingUpPanelBloc>(context)
                                      .add(OpenMiniPlayer());
                                }
                                await audioHandler.playFromMediaId(item.id);
                              },
                            )),
                  )
                ],
              ))
            ] else if (whichType == 'List<MyPlaylist>') ...[
              Flexible(
                  child: PlaylistsWrap(
                      fromPage: 'show_all_page',
                      item: (args.item! as List<MyPlaylist>),
                      pagingController: PagingController<int, MyPlaylist>(
                        firstPageKey: 1,
                      )))
            ],
          ],
        ));
  }
}
