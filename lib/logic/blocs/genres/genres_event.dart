abstract class GenresEvent {
  const GenresEvent();
}

class GetFindGenre extends GenresEvent {
  final String name;

  const GetFindGenre({required this.name});
}

class GetMoreGenres extends GenresEvent {
  final String page;

  const GetMoreGenres({required this.page});
}

class GetGenres extends GenresEvent {
  const GetGenres();
}

class GetGenre extends GenresEvent {
  final String genreId;

  const GetGenre({required this.genreId});
}
