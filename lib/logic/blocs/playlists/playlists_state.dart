import 'package:equatable/equatable.dart';
import 'package:muzzone/data/models/backend_playlist.dart';
import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/data/models/track.dart';

enum PlaylistsStatus { initial, success, failure, loading }

class PlaylistsState extends Equatable {
  final PlaylistsStatus playlistsStatus;
  final PlaylistsStatus playlistStatus;
  final String serverMessage;
  final List<BackendPlaylist> backendPlaylists;
  final BackendPlaylist backendPlaylist;
  final List<MyPlaylist> list;
  final bool hasReached;
  final int currentPage;
  final int nextPage;
  final int lastPage;
  final List<Track> tracksList;

  const PlaylistsState(
      {this.playlistsStatus = PlaylistsStatus.initial,
      this.playlistStatus = PlaylistsStatus.initial,
      this.serverMessage = '',
      this.backendPlaylists = const <BackendPlaylist>[],
      this.backendPlaylist = const BackendPlaylist(),
      this.list = const <MyPlaylist>[],
      this.hasReached = false,
      this.currentPage = -1,
      this.nextPage = -1,
      this.lastPage = -1,
      this.tracksList = const <Track>[]});

  @override
  List<Object?> get props => [
        playlistsStatus,
        playlistStatus,
        serverMessage,
        backendPlaylists,
        backendPlaylist,
        list,
        hasReached,
        currentPage,
        nextPage,
        lastPage,
        tracksList
      ];

  PlaylistsState copyWith(
      {PlaylistsStatus? playlistsStatus,
      PlaylistsStatus? playlistStatus,
      String? serverMessage,
      List<BackendPlaylist>? backendPlaylists,
      BackendPlaylist? backendPlaylist,
      List<MyPlaylist>? list,
      bool? hasReached,
      int? currentPage,
      int? nextPage,
      int? lastPage,
      List<Track>? tracksList}) {
    return PlaylistsState(
        playlistsStatus: playlistsStatus ?? this.playlistsStatus,
        playlistStatus: playlistStatus ?? this.playlistStatus,
        serverMessage: serverMessage ?? this.serverMessage,
        backendPlaylists: backendPlaylists ?? this.backendPlaylists,
        backendPlaylist: backendPlaylist ?? this.backendPlaylist,
        list: list ?? this.list,
        hasReached: hasReached ?? this.hasReached,
        currentPage: currentPage ?? this.currentPage,
        nextPage: nextPage ?? this.nextPage,
        lastPage: lastPage ?? this.lastPage,
        tracksList: tracksList ?? this.tracksList);
  }
}
