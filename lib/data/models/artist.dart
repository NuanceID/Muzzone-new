import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/data/models/track.dart';

class Artist {
  final int id;
  final String name;
  final String description;
  final List<MyPlaylist> albums;
  final List<Audio> audio;
  final String cover;
  final List<Track> tracks;

  const Artist({
    this.id = -1,
    this.name = '',
    this.description = '',
    this.albums = const <MyPlaylist>[],
    this.audio = const <Audio>[],
    this.cover = '',
    this.tracks = const <Track>[],
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    var tracksFromJson =
        json['tracks'] != null ? json['tracks'] as List : <Track>[];

    return Artist(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        albums: <MyPlaylist>[],
        audio: <Audio>[],
        cover: json['cover'] ?? '',
        tracks: tracksFromJson.map((e) => Track.fromJson(e)).toList());
  }
}
