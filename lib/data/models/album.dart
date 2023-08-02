import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzzone/data/models/track.dart';

part 'album.g.dart';

@HiveType(typeId: 3)
class Album {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final List<Track> tracks;
  @HiveField(4)
  final String cover;

  const Album(
      {this.id = -1,
      this.name = '',
      this.description = '',
      this.tracks = const <Track>[],
      this.cover = ''});

  factory Album.fromJson(Map<String, dynamic> json) {
    var tracksFromJson =
        json['tracks'] != null ? json['tracks'] as List : <Track>[];

    return Album(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        cover: json['cover'] ?? '',
        tracks: tracksFromJson.map((e) => Track.fromJson(e)).toList());
  }
}
