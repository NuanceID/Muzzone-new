import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzzone/config/network_state/network_state.dart';
import 'package:muzzone/config/path/path.dart';
import 'package:muzzone/data/data.dart';
import 'package:muzzone/data/models/genres.dart';
import 'package:muzzone/data/repositories/remote_repositories/backend_repository.dart';
import 'package:muzzone/logic/blocs/genres/genres_event.dart';
import 'package:muzzone/logic/blocs/genres/genres_state.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  final BackendRepository _backendRepository;

  GenresBloc({required BackendRepository backendRepository})
      : _backendRepository = backendRepository,
        super(const GenresState()) {
    on<GetFindGenre>(_getFindAlbum);
    on<GetMoreGenres>(_getMoreGenres);
    on<GetGenres>(_getGenres);
    on<GetGenre>(_getGenre);
  }

  _getFindAlbum(GetFindGenre event, Emitter<GenresState> emitter) async {
    emitter(state.copyWith(genreStatus: GenresStatus.loading));

    var getFindGenreResult = await _backendRepository.getFindGenre(
        Hive.box<User>('userBox').get('user')?.token ?? '', event.name);

    if (getFindGenreResult is NetworkStateFailed) {
      return emitter(state.copyWith(genreStatus: GenresStatus.failure));
    }

    if (getFindGenreResult is NetworkStateSuccess) {
      return emitter(state.copyWith(
        genreStatus: GenresStatus.success,
      ));
    }
  }

  _getMoreGenres(GetMoreGenres event, Emitter<GenresState> emitter) async {
    if (state.hasReached) return;

    emitter(state.copyWith(genresStatus: GenresStatus.loading));

    var genresResult = await _backendRepository.getMoreGenres(
        Hive.box<User>('userBox').get('user')?.token ?? '', event.page);

    if (genresResult is NetworkStateFailed) {
      return emitter(state.copyWith(genresStatus: GenresStatus.failure));
    }

    if (genresResult is NetworkStateSuccess) {
      Genres genres = genresResult.data?.data != null
          ? Genres.fromJson(genresResult.data?.data)
          : Genres();

      var genresList = genres.data
          .map((e) => MyPlaylist(
              id: e.id, title: e.name, image: e.cover, isGenre: true))
          .toList();

      var nextPage = genres.meta.currentPage < genres.meta.lastPage
          ? genres.meta.currentPage + 1
          : genres.meta.lastPage;

      return emitter(state.copyWith(
          genresStatus: GenresStatus.success,
          genresList: genresList,
          hasReached: genres.meta.currentPage >= genres.meta.lastPage,
          currentPage: genres.meta.currentPage,
          nextPage: nextPage,
          lastPage: genres.meta.lastPage));
    }
  }

  _getGenres(GetGenres event, Emitter<GenresState> emitter) async {
    emitter(state.copyWith(genresStatus: GenresStatus.loading));

    var genresResult = await _backendRepository
        .getGenres(Hive.box<User>('userBox').get('user')?.token ?? '');

    if (genresResult is NetworkStateFailed) {
      return emitter(state.copyWith(genresStatus: GenresStatus.failure));
    }

    if (genresResult is NetworkStateSuccess) {
      Genres genres = genresResult.data?.data != null
          ? Genres.fromJson(genresResult.data?.data)
          : Genres();

      var genresList = genres.data
          .map((e) => MyPlaylist(
              id: e.id, title: e.name, image: e.cover, isGenre: true))
          .toList();

      genresList.insert(
          0,
          const MyPlaylist(
              title: 'По жанру', image: '${imagesMainPagePath}111.png'));

      return emitter(state.copyWith(
          genresStatus: GenresStatus.success, genresList: genresList));
    }
  }

  _getGenre(GetGenre event, Emitter<GenresState> emitter) async {
    emitter(state.copyWith(genreStatus: GenresStatus.loading));

    var genreResult = await _backendRepository.getGenre(
        Hive.box<User>('userBox').get('user')?.token ?? '', event.genreId);

    if (genreResult is NetworkStateFailed) {
      return emitter(state.copyWith(genreStatus: GenresStatus.failure));
    }

    if (genreResult is NetworkStateSuccess) {
      Genre genre = const Genre();
      if (genreResult.data!.data['data'] != null) {
        genre = Genre.fromJson(genreResult.data!.data['data']);
      }

      return emitter(state.copyWith(
          genreStatus: GenresStatus.success,
          genre: genre,
          tracksList: genre.tracks));
    }
  }
}
