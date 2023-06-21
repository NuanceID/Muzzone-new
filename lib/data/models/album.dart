import 'package:muzzone/data/models/track.dart';

class Album {
  final int id;
  final String name;
  final String description;
  final List<Track> tracks;
  final String cover;

  const Album(
      {this.id = -1,
        this.name = '',
        this.description = '',
        this.tracks = const <Track>[],
        this.cover = ''});

  factory Album.fromJson(Map<String, dynamic> json) {
    var tracksFromJson = json['tracks'] != null ? json['tracks'] as List : <Track>[];

    return Album(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        cover: json['cover'] ?? '',
        tracks: tracksFromJson.map((e) => Track.fromJson(e)).toList());
  }
}
