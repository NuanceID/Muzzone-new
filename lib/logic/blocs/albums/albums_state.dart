import 'package:equatable/equatable.dart';
import 'package:muzzone/data/models/album.dart';
import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/data/models/track.dart';

enum AlbumsStatus { initial, success, failure, loading }

class AlbumsState extends Equatable {
  final AlbumsStatus albumsStatus;
  final AlbumsStatus albumStatus;
  final String serverMessage;
  final List<Album> albums;
  final Album album;
  final List<MyPlaylist> albumsList;
  final bool hasReached;
  final int currentPage;
  final int nextPage;
  final int lastPage;
  final List<Track> tracksList;

  const AlbumsState(
      {this.albumsStatus = AlbumsStatus.initial,
      this.albumStatus = AlbumsStatus.initial,
      this.serverMessage = '',
      this.albums = const <Album>[],
      this.album = const Album(),
      this.albumsList = const <MyPlaylist>[],
      this.hasReached = false,
      this.currentPage = -1,
      this.nextPage = -1,
      this.lastPage = -1,
      this.tracksList = const <Track>[]});

  @override
  List<Object?> get props => [
        albumsStatus,
        albumStatus,
        serverMessage,
        albums,
        album,
        albumsList,
        hasReached,
        currentPage,
        nextPage,
        lastPage,
        tracksList
      ];

  AlbumsState copyWith(
      {AlbumsStatus? albumsStatus,
      AlbumsStatus? albumStatus,
      String? serverMessage,
      List<Album>? albums,
      Album? album,
      List<MyPlaylist>? albumsList,
      bool? hasReached,
      int? currentPage,
      int? nextPage,
      int? lastPage,
      List<Track>? tracksList}) {
    return AlbumsState(
        albumsStatus: albumsStatus ?? this.albumsStatus,
        albumStatus: albumStatus ?? this.albumStatus,
        serverMessage: serverMessage ?? this.serverMessage,
        albums: albums ?? this.albums,
        album: album ?? this.album,
        albumsList: albumsList ?? this.albumsList,
        hasReached: hasReached ?? this.hasReached,
        currentPage: currentPage ?? this.currentPage,
        nextPage: nextPage ?? this.nextPage,
        lastPage: lastPage ?? this.lastPage,
        tracksList: tracksList ?? this.tracksList);
  }
}
