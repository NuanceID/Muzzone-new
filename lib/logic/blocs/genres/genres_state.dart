import 'package:equatable/equatable.dart';
import 'package:muzzone/data/models/genre.dart';
import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/data/models/track.dart';

enum GenresStatus { initial, success, failure, loading }

class GenresState extends Equatable {
  final GenresStatus genresStatus;
  final GenresStatus genreStatus;
  final String serverMessage;
  final List<Genre> genres;
  final Genre genre;
  final List<MyPlaylist> genresList;
  final bool hasReached;
  final int currentPage;
  final int nextPage;
  final int lastPage;
  final List<Track> tracksList;

  const GenresState(
      {this.genresStatus = GenresStatus.initial,
      this.genreStatus = GenresStatus.initial,
      this.serverMessage = '',
      this.genres = const <Genre>[],
      this.genre = const Genre(),
      this.genresList = const <MyPlaylist>[],
      this.hasReached = false,
      this.currentPage = -1,
      this.nextPage = -1,
      this.lastPage = -1,
      this.tracksList = const <Track>[]});

  @override
  List<Object?> get props => [
        genresStatus,
        genreStatus,
        serverMessage,
        genres,
        genre,
        genresList,
        hasReached,
        currentPage,
        nextPage,
        lastPage,
        tracksList
      ];

  GenresState copyWith(
      {GenresStatus? genresStatus,
      GenresStatus? genreStatus,
      String? serverMessage,
      List<Genre>? genres,
      Genre? genre,
      List<MyPlaylist>? genresList,
      bool? hasReached,
      int? currentPage,
      int? nextPage,
      int? lastPage,
      List<Track>? tracksList}) {
    return GenresState(
        genresStatus: genresStatus ?? this.genresStatus,
        genreStatus: genreStatus ?? this.genreStatus,
        serverMessage: serverMessage ?? this.serverMessage,
        genres: genres ?? this.genres,
        genre: genre ?? this.genre,
        genresList: genresList ?? this.genresList,
        hasReached: hasReached ?? this.hasReached,
        currentPage: currentPage ?? this.currentPage,
        nextPage: nextPage ?? this.nextPage,
        lastPage: lastPage ?? this.lastPage,
        tracksList: tracksList ?? this.tracksList);
  }
}
