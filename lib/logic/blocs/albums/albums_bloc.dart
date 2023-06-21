import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzzone/config/network_state/network_state.dart';
import 'package:muzzone/data/models/album.dart';
import 'package:muzzone/data/models/albums.dart';
import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/data/models/user.dart';
import 'package:muzzone/data/repositories/remote_repositories/backend_repository.dart';
import 'package:muzzone/logic/blocs/albums/albums_event.dart';
import 'package:muzzone/logic/blocs/albums/albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  final BackendRepository _backendRepository;

  AlbumsBloc({required BackendRepository backendRepository})
      : _backendRepository = backendRepository,
        super(const AlbumsState()) {
    on<GetFindAlbum>(_getFindAlbum);
    on<GetMoreAlbums>(_getMoreAlbums);
    on<GetAlbums>(_getAlbums);
    on<GetAlbum>(_getAlbum);
  }

  _getFindAlbum(GetFindAlbum event, Emitter<AlbumsState> emitter) async {
    emitter(state.copyWith(albumStatus: AlbumsStatus.loading));

    var getFindAlbumResult = await _backendRepository.getFindAlbum(
        Hive.box<User>('userBox').get('user')?.token ?? '', event.name);

    if (getFindAlbumResult is NetworkStateFailed) {
      return emitter(state.copyWith(albumStatus: AlbumsStatus.failure));
    }

    if (getFindAlbumResult is NetworkStateSuccess) {

      return emitter(state.copyWith(
          albumStatus: AlbumsStatus.success,));
    }
  }

  _getMoreAlbums(GetMoreAlbums event, Emitter<AlbumsState> emitter) async {
    if (state.hasReached) return;

    emitter(state.copyWith(albumsStatus: AlbumsStatus.loading));

    var albumsResult = await _backendRepository
        .getMoreAlbums(Hive.box<User>('userBox').get('user')?.token ?? '', event.page);

    if (albumsResult is NetworkStateFailed) {
      return emitter(state.copyWith(albumsStatus: AlbumsStatus.failure));
    }

    if (albumsResult is NetworkStateSuccess) {
      Albums albums = albumsResult.data?.data != null
          ? Albums.fromJson(albumsResult.data?.data)
          : Albums();

      var albumsList = albums.data
          .map((e) => MyPlaylist(
          id: e.id, title: e.name, image: e.cover, isAlbum: true))
          .toList();

      var nextPage = albums.meta.currentPage < albums.meta.lastPage ? albums.meta.currentPage + 1 : albums.meta.lastPage;

      return emitter(state.copyWith(
          albumsStatus: AlbumsStatus.success,
          albumsList: albumsList,
          hasReached: albums.meta.currentPage >= albums.meta.lastPage,
          currentPage: albums.meta.currentPage,
          nextPage: nextPage,
          lastPage: albums.meta.lastPage,));
    }
  }

  _getAlbums(GetAlbums event, Emitter<AlbumsState> emitter) async {
    emitter(state.copyWith(albumsStatus: AlbumsStatus.loading));

    var albumsResult = await _backendRepository
        .getAlbums(Hive.box<User>('userBox').get('user')?.token ?? '');

    if (albumsResult is NetworkStateFailed) {
      return emitter(state.copyWith(albumsStatus: AlbumsStatus.failure));
    }

    if (albumsResult is NetworkStateSuccess) {
      Albums albums = albumsResult.data?.data != null
          ? Albums.fromJson(albumsResult.data?.data)
          : Albums();

      var albumsList = albums.data
          .map((e) => MyPlaylist(
              id: e.id, title: e.name, image: e.cover, isAlbum: true))
          .toList();

      return emitter(state.copyWith(
          albumsStatus: AlbumsStatus.success, albumsList: albumsList));
    }
  }

  _getAlbum(GetAlbum event, Emitter<AlbumsState> emitter) async {
    emitter(state.copyWith(albumStatus: AlbumsStatus.loading));

    var albumResult = await _backendRepository.getAlbum(
        Hive.box<User>('userBox').get('user')?.token ?? '', event.albumId);

    if (albumResult is NetworkStateFailed) {
      return emitter(state.copyWith(albumStatus: AlbumsStatus.failure));
    }

    if (albumResult is NetworkStateSuccess) {
      Album album = const Album();
      if (albumResult.data!.data['data'] != null) {
        album =
            Album.fromJson(albumResult.data!.data['data']);
      }

      return emitter(state.copyWith(
          albumStatus: AlbumsStatus.success,
          album: album,
          tracksList: album.tracks));
    }
  }
}
