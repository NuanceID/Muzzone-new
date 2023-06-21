import 'package:muzzone/data/models/track.dart';

class Genre {
  final int id;
  final String name;
  final String description;
  final String cover;
  final List<Track> tracks;

  const Genre({
    this.id = -1,
    this.name = '',
    this.description = '',
    this.cover = '',
    this.tracks = const <Track>[],
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    var tracksFromJson = json['tracks'] != null ? json['tracks'] as List : <Track>[];

    return Genre(
        id: json['id'] ?? -1,
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        cover: json['cover'] ?? '',
        tracks: tracksFromJson.map((e) => Track.fromJson(e)).toList());
  }
}
