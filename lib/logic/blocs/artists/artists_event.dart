abstract class ArtistsEvent {
  const ArtistsEvent();
}

class GetFindArtist extends ArtistsEvent {
  final String name;

  const GetFindArtist({required this.name});
}

class GetMoreArtists extends ArtistsEvent {
  final String page;
  const GetMoreArtists({required this.page});
}

class GetArtists extends ArtistsEvent {
  const GetArtists();
}

class GetArtist extends ArtistsEvent {
  final String artistId;

  const GetArtist({required this.artistId});
}
