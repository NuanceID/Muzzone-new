import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzzone/config/network_state/network_state.dart';
import 'package:muzzone/data/models/artist.dart';
import 'package:muzzone/data/models/artists.dart';
import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/data/models/user.dart';
import 'package:muzzone/data/repositories/remote_repositories/backend_repository.dart';
import 'package:muzzone/logic/blocs/artists/artists_event.dart';
import 'package:muzzone/logic/blocs/artists/artists_state.dart';

class ArtistsBloc extends Bloc<ArtistsEvent, ArtistsState> {
  final BackendRepository _backendRepository;

  ArtistsBloc({required BackendRepository backendRepository})
      : _backendRepository = backendRepository,
        super(const ArtistsState()) {
    on<GetFindArtist>(_getFindArtist);
    on<GetMoreArtists>(_getMoreArtists);
    on<GetArtists>(_getArtists);
    on<GetArtist>(_getArtist);
  }

  _getFindArtist(GetFindArtist event, Emitter<ArtistsState> emitter) async {
    emitter(state.copyWith(artistStatus: ArtistsStatus.loading));

    var getFindArtistResult = await _backendRepository.getFindArtist(
        Hive.box<User>('userBox').get('user')?.token ?? '', event.name);

    if (getFindArtistResult is NetworkStateFailed) {
      return emitter(state.copyWith(artistStatus: ArtistsStatus.failure));
    }

    if (getFindArtistResult is NetworkStateSuccess) {

      return emitter(state.copyWith(
        artistStatus: ArtistsStatus.success,));
    }
  }

  _getMoreArtists(GetMoreArtists event, Emitter<ArtistsState> emitter) async {
    if (state.hasReached) return;

    emitter(state.copyWith(artistsStatus: ArtistsStatus.loading));

    var artistsResult = await _backendRepository.getMoreArtists(
        Hive.box<User>('userBox').get('user')?.token ?? '', event.page);

    if (artistsResult is NetworkStateFailed) {
      return emitter(state.copyWith(artistsStatus: ArtistsStatus.failure));
    }

    if (artistsResult is NetworkStateSuccess) {
      Artists artists = artistsResult.data?.data != null
          ? Artists.fromJson(artistsResult.data?.data)
          : Artists();

      var artistsList = artists.data
          .map((e) => MyPlaylist(
              id: e.id, title: e.name, image: e.cover, isArtist: true))
          .toList();

      var nextPage = artists.meta.currentPage < artists.meta.lastPage
          ? artists.meta.currentPage + 1
          : artists.meta.lastPage;

      return emitter(state.copyWith(
          artistsStatus: ArtistsStatus.success,
          artistsList: artistsList,
          hasReached: artists.meta.currentPage >= artists.meta.lastPage,
          currentPage: artists.meta.currentPage,
          nextPage: nextPage,
          lastPage: artists.meta.lastPage));
    }
  }

  _getArtists(GetArtists event, Emitter<ArtistsState> emitter) async {
    emitter(state.copyWith(artistsStatus: ArtistsStatus.loading));

    var artistsResult = await _backendRepository
        .getArtists(Hive.box<User>('userBox').get('user')?.token ?? '');

    if (artistsResult is NetworkStateFailed) {
      return emitter(state.copyWith(artistsStatus: ArtistsStatus.failure));
    }

    if (artistsResult is NetworkStateSuccess) {
      Artists artists = artistsResult.data?.data != null
          ? Artists.fromJson(artistsResult.data?.data)
          : Artists();

      var artistsList = artists.data
          .map((e) => MyPlaylist(
              id: e.id, title: e.name, image: e.cover, isArtist: true))
          .toList();

      return emitter(state.copyWith(
          artistsStatus: ArtistsStatus.success, artistsList: artistsList));
    }
  }

  _getArtist(GetArtist event, Emitter<ArtistsState> emitter) async {
    emitter(state.copyWith(artistStatus: ArtistsStatus.loading));

    var artistResult = await _backendRepository.getAlbum(
        Hive.box<User>('userBox').get('user')?.token ?? '', event.artistId);

    if (artistResult is NetworkStateFailed) {
      return emitter(state.copyWith(artistStatus: ArtistsStatus.failure));
    }

    if (artistResult is NetworkStateSuccess) {
      Artist artist = const Artist();
      if (artistResult.data!.data['data'] != null) {
        artist = Artist.fromJson(artistResult.data!.data['data']);
      }

      return emitter(state.copyWith(
          artistStatus: ArtistsStatus.success,
          artist: artist,
          tracksList: artist.tracks));
    }
  }
}
