abstract class AlbumsEvent {
  const AlbumsEvent();
}

class GetFindAlbum extends AlbumsEvent {
  final String name;

  const GetFindAlbum({required this.name});
}

class GetMoreAlbums extends AlbumsEvent {
  final String page;

  const GetMoreAlbums({required this.page});
}

class GetAlbums extends AlbumsEvent {
  const GetAlbums();
}

class GetAlbum extends AlbumsEvent {
  final String albumId;

  const GetAlbum({required this.albumId});
}
