import 'package:muzzone/data/models/album.dart';
import 'package:muzzone/data/models/artist.dart';

class Track {
  final int id;
  final String name;
  final String description;
  final String cover;
  final String file;
  final Album album;
  final List<Artist> artists;
  final String genres;
  final String audio;
  final int isPopular;
  final int isNew;

  const Track(
      {this.id = -1,
      this.name = '',
      this.description = '',
      this.cover = '',
      this.file = '',
      this.album = const Album(),
      this.artists = const <Artist>[],
      this.genres = '',
      this.audio = '',
      this.isPopular = -1,
      this.isNew = -1});

  factory Track.fromJson(Map<String, dynamic> json) {
    var artistsFromJson = json['artists'] != null ? json['artists'] as List : <Artist>[];

    return Track(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      cover: json['cover'] ?? '',
      file: json['file'] ?? '',
      album: json['album'] != null ? Album.fromJson(json['album']) : const Album(),
      artists: artistsFromJson.map((e) => Artist.fromJson(e)).toList(),
      genres: '',
      audio: '',
      isPopular: -1,
      isNew: -1,
    );
  }
}
