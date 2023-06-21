import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzzone/config/network_state/network_state.dart';
import 'package:muzzone/data/models/backend_playlist.dart';
import 'package:muzzone/data/models/backend_playlists.dart';
import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/data/models/user.dart';
import 'package:muzzone/data/repositories/remote_repositories/backend_repository.dart';
import 'package:muzzone/logic/blocs/playlists/playlists_event.dart';
import 'package:muzzone/logic/blocs/playlists/playlists_state.dart';

class PlaylistsBloc extends Bloc<PlaylistsEvent, PlaylistsState> {
  final BackendRepository _backendRepository;

  PlaylistsBloc({required BackendRepository backendRepository})
      : _backendRepository = backendRepository,
        super(const PlaylistsState()) {
    on<GetFindPlaylist>(_getFindPlaylist);
    on<GetMorePlaylists>(_getMorePlaylists);
    on<GetPlaylists>(_getPlaylists);
    on<GetPlaylist>(_getPlaylist);
  }

  _getFindPlaylist(GetFindPlaylist event, Emitter<PlaylistsState> emitter) async {
    emitter(state.copyWith(playlistStatus: PlaylistsStatus.loading));

    var getFindPlaylistResult = await _backendRepository.getFindBackendPlaylist(
        Hive.box<User>('userBox').get('user')?.token ?? '', event.name);

    if (getFindPlaylistResult is NetworkStateFailed) {
      return emitter(state.copyWith(playlistStatus: PlaylistsStatus.failure));
    }

    if (getFindPlaylistResult is NetworkStateSuccess) {
      return emitter(state.copyWith(
        playlistStatus: PlaylistsStatus.success,));
    }
  }

  _getMorePlaylists(
      GetMorePlaylists event, Emitter<PlaylistsState> emitter) async {
    if (state.hasReached) return;

    emitter(state.copyWith(playlistsStatus: PlaylistsStatus.loading));

    var playlistsResult = await _backendRepository.getMorePlaylists(
        Hive.box<User>('userBox').get('user')?.token ?? '', event.page);

    if (playlistsResult is NetworkStateFailed) {
      return emitter(state.copyWith(playlistsStatus: PlaylistsStatus.failure));
    }

    if (playlistsResult is NetworkStateSuccess) {
      BackendPlaylists playlists = playlistsResult.data?.data != null
          ? BackendPlaylists.fromJson(playlistsResult.data?.data)
          : BackendPlaylists();

      var playlistsList = playlists.data
          .map((e) => MyPlaylist(
              id: e.id, title: e.name, image: e.cover, isBackendPlaylist: true))
          .toList();

      var nextPage = playlists.meta.currentPage < playlists.meta.lastPage
          ? playlists.meta.currentPage + 1
          : playlists.meta.lastPage;

      return emitter(state.copyWith(
          playlistsStatus: PlaylistsStatus.success,
          list: playlistsList,
          hasReached: playlists.meta.currentPage >= playlists.meta.lastPage,
          currentPage: playlists.meta.currentPage,
          nextPage: nextPage,
          lastPage: playlists.meta.lastPage));
    }
  }

  _getPlaylists(GetPlaylists event, Emitter<PlaylistsState> emitter) async {
    emitter(state.copyWith(playlistsStatus: PlaylistsStatus.loading));

    var playlistsResult = await _backendRepository
        .getPlaylists(Hive.box<User>('userBox').get('user')?.token ?? '');

    if (playlistsResult is NetworkStateFailed) {
      return emitter(state.copyWith(playlistsStatus: PlaylistsStatus.failure));
    }

    if (playlistsResult is NetworkStateSuccess) {
      BackendPlaylists playlists = playlistsResult.data?.data != null
          ? BackendPlaylists.fromJson(playlistsResult.data?.data)
          : BackendPlaylists();

      var playlistsList = playlists.data
          .map((e) => MyPlaylist(
              id: e.id, title: e.name, image: e.cover, isBackendPlaylist: true))
          .toList();

      var editedPlaylistsList = playlistsList
          .where((element) => element.title != "В трендах")
          .toList();

      return emitter(state.copyWith(
          playlistsStatus: PlaylistsStatus.success, list: editedPlaylistsList));
    }
  }

  _getPlaylist(GetPlaylist event, Emitter<PlaylistsState> emitter) async {
    emitter(state.copyWith(playlistStatus: PlaylistsStatus.loading));

    var playlistResult = await _backendRepository.getPlaylist(
        Hive.box<User>('userBox').get('user')?.token ?? '', event.playlistId);

    if (playlistResult is NetworkStateFailed) {
      return emitter(state.copyWith(playlistStatus: PlaylistsStatus.failure));
    }

    if (playlistResult is NetworkStateSuccess) {
      BackendPlaylist backendPlaylist = const BackendPlaylist();
      if (playlistResult.data!.data['data'] != null) {
        backendPlaylist =
            BackendPlaylist.fromJson(playlistResult.data!.data['data']);
      }

      return emitter(state.copyWith(
          playlistStatus: PlaylistsStatus.success,
          backendPlaylist: backendPlaylist,
          tracksList: backendPlaylist.tracks));
    }
  }
}
