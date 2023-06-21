abstract class TracksEvent {
  const TracksEvent();
}

class GetFindTrack extends TracksEvent {
  final String name;

  const GetFindTrack({required this.name});
}

class GetMoreTracks extends TracksEvent {
  final String page;
  const GetMoreTracks({required this.page});
}

class GetTracks extends TracksEvent {
  const GetTracks();
}

class GetTrack extends TracksEvent {
  final String trackId;

  const GetTrack({required this.trackId});
}
