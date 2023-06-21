import 'package:muzzone/data/models/track.dart';

class BackendPlaylist {
  final int id;
  final String name;
  final String description;
  final String cover;
  final List<Track> tracks;

  const BackendPlaylist(
      {this.id = -1,
      this.name = '',
      this.description = '',
      this.cover = '',
      this.tracks = const <Track>[]});

  factory BackendPlaylist.fromJson(Map<String, dynamic> json) {
    var tracksFromJson =
        json['tracks'] != null ? json['tracks'] as List : <Track>[];

    return BackendPlaylist(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        cover: json['cover'] ?? '',
        tracks: tracksFromJson.map((e) => Track.fromJson(e)).toList());
  }
}
