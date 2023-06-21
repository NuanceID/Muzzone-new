import 'package:equatable/equatable.dart';
import 'package:muzzone/data/models/track.dart';

enum TracksStatus { initial, success, failure, loading }

class TracksState extends Equatable {
  final TracksStatus tracksStatus;
  final TracksStatus trackStatus;
  final String serverMessage;
  final List<Track> tracks;
  final Track track;
  final bool hasReached;
  final int currentPage;
  final int nextPage;
  final int lastPage;

  const TracksState({
    this.tracksStatus = TracksStatus.initial,
    this.trackStatus = TracksStatus.initial,
    this.serverMessage = '',
    this.tracks = const <Track>[],
    this.track = const Track(),
    this.hasReached = false,
    this.currentPage = -1,
    this.nextPage = -1,
    this.lastPage = -1,
  });

  @override
  List<Object?> get props => [
        tracksStatus,
        trackStatus,
        serverMessage,
        tracks,
        track,
        hasReached,
        currentPage,
        nextPage,
        lastPage,
      ];

  TracksState copyWith({
    TracksStatus? tracksStatus,
    TracksStatus? trackStatus,
    String? serverMessage,
    List<Track>? tracks,
    Track? track,
    bool? hasReached,
    int? currentPage,
    int? nextPage,
    int? lastPage,
  }) {
    return TracksState(
      tracksStatus: tracksStatus ?? this.tracksStatus,
      trackStatus: trackStatus ?? this.tracksStatus,
      serverMessage: serverMessage ?? this.serverMessage,
      tracks: tracks ?? this.tracks,
      track: track ?? this.track,
      hasReached: hasReached ?? this.hasReached,
      currentPage: currentPage ?? this.currentPage,
      nextPage: nextPage ?? this.nextPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }
}
