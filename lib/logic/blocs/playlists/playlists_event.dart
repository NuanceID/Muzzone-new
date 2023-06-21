abstract class PlaylistsEvent {
  const PlaylistsEvent();
}

class GetFindPlaylist extends PlaylistsEvent {
  final String name;

  const GetFindPlaylist({required this.name});
}

class GetMorePlaylists extends PlaylistsEvent {
  final String page;
  const GetMorePlaylists({required this.page});
}

class GetPlaylists extends PlaylistsEvent {
  const GetPlaylists();
}

class GetPlaylist extends PlaylistsEvent {
  final String playlistId;

  const GetPlaylist({required this.playlistId});
}
