import 'package:audio_service/audio_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/data/models/track.dart';

part 'artist.g.dart';

@HiveType(typeId: 4)
class Artist {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final List<MyPlaylist> albums;
  final List<MediaItem> audio;
  @HiveField(4)
  final String cover;
  @HiveField(5)
  final List<Track> tracks;

  const Artist({
    this.id = -1,
    this.name = '',
    this.description = '',
    this.albums = const <MyPlaylist>[],
    this.audio = const <MediaItem>[],
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
        audio: <MediaItem>[],
        cover: json['cover'] ?? '',
        tracks: tracksFromJson.map((e) => Track.fromJson(e)).toList());
  }
}
