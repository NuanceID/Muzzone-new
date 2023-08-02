import 'package:equatable/equatable.dart';
import 'package:muzzone/data/models/track.dart';

enum RecentTracksStatus { initial, success, failure, loading }

class RecentTracksState extends Equatable {
  final RecentTracksStatus recentTracksStatus;
  final List<Track> recentTracks;
  final Track currentTrack;

  const RecentTracksState(
      {this.recentTracksStatus = RecentTracksStatus.initial,
      this.recentTracks = const <Track>[],
      this.currentTrack = const Track()});

  @override
  List<Object?> get props => [recentTracksStatus, recentTracks, currentTrack];

  RecentTracksState copyWith(
      {RecentTracksStatus? recentTracksStatus,
      List<Track>? recentTracks,
      Track? currentTrack}) {
    return RecentTracksState(
        recentTracksStatus: recentTracksStatus ?? this.recentTracksStatus,
        recentTracks: recentTracks ?? this.recentTracks,
        currentTrack: currentTrack ?? this.currentTrack);
  }
}
