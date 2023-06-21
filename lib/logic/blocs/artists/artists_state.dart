import 'package:equatable/equatable.dart';
import 'package:muzzone/data/models/artist.dart';
import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/data/models/track.dart';

enum ArtistsStatus { initial, success, failure, loading }

class ArtistsState extends Equatable {
  final ArtistsStatus artistsStatus;
  final ArtistsStatus artistStatus;
  final String serverMessage;
  final List<Artist> artists;
  final Artist artist;
  final List<MyPlaylist> artistsList;
  final bool hasReached;
  final int currentPage;
  final int nextPage;
  final int lastPage;
  final List<Track> tracksList;

  const ArtistsState(
      {this.artistsStatus = ArtistsStatus.initial,
      this.artistStatus = ArtistsStatus.initial,
      this.serverMessage = '',
      this.artists = const <Artist>[],
      this.artist = const Artist(),
      this.artistsList = const <MyPlaylist>[],
      this.hasReached = false,
      this.currentPage = -1,
      this.nextPage = -1,
      this.lastPage = -1,
      this.tracksList = const <Track>[]});

  @override
  List<Object?> get props => [
        artistsStatus,
        artistStatus,
        serverMessage,
        artists,
        artist,
        artistsList,
        hasReached,
        currentPage,
        nextPage,
        lastPage,
        tracksList
      ];

  ArtistsState copyWith(
      {ArtistsStatus? artistsStatus,
      ArtistsStatus? artistStatus,
      String? serverMessage,
      List<Artist>? artists,
      Artist? artist,
      List<MyPlaylist>? artistsList,
      bool? hasReached,
      int? currentPage,
      int? nextPage,
      int? lastPage,
      List<Track>? tracksList}) {
    return ArtistsState(
        artistsStatus: artistsStatus ?? this.artistsStatus,
        artistStatus: artistStatus ?? this.artistStatus,
        serverMessage: serverMessage ?? this.serverMessage,
        artists: artists ?? this.artists,
        artist: artist ?? this.artist,
        artistsList: artistsList ?? this.artistsList,
        hasReached: hasReached ?? this.hasReached,
        currentPage: currentPage ?? this.currentPage,
        nextPage: nextPage ?? this.nextPage,
        lastPage: lastPage ?? this.lastPage,
        tracksList: tracksList ?? this.tracksList);
  }
}
