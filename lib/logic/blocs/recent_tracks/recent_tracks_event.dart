import 'package:muzzone/data/models/track.dart';

abstract class RecentTracksEvent {
  const RecentTracksEvent();
}

class GetRecentTracks extends RecentTracksEvent {
  const GetRecentTracks();
}

class PutTrack extends RecentTracksEvent {
  final Track track;

  const PutTrack({required this.track});
}

class SetCurrentTrack extends RecentTracksEvent {
  final Track track;

  const SetCurrentTrack({required this.track});
}
