import 'package:audio_service/audio_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/data/repositories/remote_repositories/backend_repository.dart';
import 'package:muzzone/generated/locale_keys.g.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel/sliding_up_panel_bloc.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel/sliding_up_panel_event.dart';
import 'package:muzzone/logic/blocs/genres/genres_bloc.dart';
import 'package:muzzone/logic/blocs/genres/genres_event.dart';
import 'package:muzzone/logic/blocs/genres/genres_state.dart';
import 'package:muzzone/logic/blocs/playlists/playlists_bloc.dart';
import 'package:muzzone/logic/blocs/playlists/playlists_event.dart';
import 'package:muzzone/logic/blocs/playlists/playlists_state.dart';
import 'package:muzzone/main.dart';
import 'package:muzzone/ui/widgets/widgets.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({Key? key}) : super(key: key);

  static const id = '/album_page';

  @override
  Widget build(BuildContext context) {
    late Bloc bloc;

    final PagingController<int, MediaItem> pagingController =
        PagingController<int, MediaItem>(firstPageKey: 1);

    final initArgs =
        ModalRoute.of(context)!.settings.arguments as AlbumPageArguments;

    if (initArgs.item is MyPlaylist) {
      if ((initArgs.item as MyPlaylist).isGenre) {
        bloc = GenresBloc(backendRepository: context.read<BackendRepository>());
      }
      if ((initArgs.item as MyPlaylist).isBackendPlaylist) {
        bloc =
            PlaylistsBloc(backendRepository: context.read<BackendRepository>());
      }
    }

    if (initArgs.item is! MyPlaylist) {
      bloc = GenresBloc(backendRepository: context.read<BackendRepository>());
    }

    return initArgs.item is MyPlaylist
        ? MultiBlocProvider(
            providers: [
                if ((initArgs.item as MyPlaylist).isGenre) ...[
                  BlocProvider<GenresBloc>(
                      create: (BuildContext context) => bloc as GenresBloc),
                ],
                if ((initArgs.item as MyPlaylist).isBackendPlaylist) ...[
                  BlocProvider<PlaylistsBloc>(
                      create: (BuildContext context) => bloc as PlaylistsBloc)
                ]
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
                              artist: e.artists.map((element) => element.name).toList().join(', '),
                              artUri: Uri.parse(e.cover),

                            )).toList();

                            await audioHandler.addQueueItems(playlist);

                            pagingController.appendLastPage(playlist);

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
                              artist: e.artists.map((element) => element.name).toList().join(', '),
                              artUri: Uri.parse(e.cover),

                            )).toList();

                            await audioHandler.addQueueItems(playlist);

                            pagingController.appendLastPage(playlist);

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
                child: _AlbumPage(
                    bloc: bloc,
                    pagingController: pagingController,
                    myPlaylist: initArgs.item as MyPlaylist)))
        : _AlbumPage(
            bloc: bloc,
            pagingController: pagingController,
            myPlaylist: const MyPlaylist(),
          );
  }
}

class _AlbumPage extends StatefulWidget {
  const _AlbumPage({
    required this.bloc,
    required this.pagingController,
    required this.myPlaylist,
  });

  final Bloc bloc;
  final PagingController<int, MediaItem> pagingController;
  final MyPlaylist myPlaylist;

  @override
  State<_AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<_AlbumPage> {
  @override
  void initState() {
    widget.pagingController.addPageRequestListener((pageKey) {
      if (widget.myPlaylist.isGenre) {
        widget.bloc.add(GetGenre(genreId: widget.myPlaylist.id.toString()));
      }
      if (widget.myPlaylist.isBackendPlaylist) {
        widget.bloc
            .add(GetPlaylist(playlistId: widget.myPlaylist.id.toString()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as AlbumPageArguments;

    return args.item is MyPlaylist
        ? Column(
            children: [
              HeaderTitle(
                title: (args.item as MyPlaylist).title,
              ),
              SizedBox(
                  height: 500,
                  child: CustomScrollView(
                    slivers: [
                      PagedSliverList<int, MediaItem>(
                        pagingController: widget.pagingController,
                        builderDelegate: PagedChildBuilderDelegate<MediaItem>(
                            noItemsFoundIndicatorBuilder: (_) => Center(
                                    child: Text(
                                  LocaleKeys.no_content.tr(),
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                )),
                            firstPageErrorIndicatorBuilder: (_) => Center(
                                    child: Text(
                                  LocaleKeys.something_went_wrong.tr(),
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                )),
                            newPageErrorIndicatorBuilder: (_) => Center(
                                    child: Text(
                                  LocaleKeys.something_went_wrong.tr(),
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                )),
                            itemBuilder: (context, item, index) => AudioRow(
                                  audio: item,
                                  onPress: () async {
                                    if(mounted) {
                                      BlocProvider.of<SlidingUpPanelBloc>(context).add(OpenMiniPlayer());
                                    }
                                    await audioHandler.playFromMediaId(item.id);
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
                    padding: EdgeInsets.only(top: 3.h),
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: state.genre.tracks.length,
                    itemBuilder: (context, index) => AudioRow(
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
                            image: MetasImage.network(
                                state.genre.tracks[index].cover),
                          ),
                        ),
                        onPress: () {
                          con.playSong(con.audios, index);
                          audioBloc.add(StartPlaying(con.audios));
                        },
                        height: 7.h),
                  );
                })
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
                    padding: EdgeInsets.only(top: 3.h),
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: state.backendPlaylist.tracks.length,
                    itemBuilder: (context, index) => AudioRow(
                        audio: Audio.network(
                          state.backendPlaylist.tracks[index].file,
                          metas: Metas(
                            id: state.backendPlaylist.tracks[index].id
                                .toString(),
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
                        height: 7.h),
                  );
                })
              ],*/
            ],
          )
        : args.album != null
            ? Column(
                children: [
                  HeaderTitle(
                    title: args.album![0].album,
                  ),
                  ListView.builder(
                    padding: EdgeInsets.only(top: 3.h),
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: args.album!.length,
                    itemBuilder: (context, index) => AudioRow(
                      audio: args.album![index],
                      onPress: () async {
                        if(mounted) {
                          BlocProvider.of<SlidingUpPanelBloc>(context).add(OpenMiniPlayer());
                        }
                        await audioHandler.playFromMediaId(args.album![index].id);
                      },
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink();
  }
}
