import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzzone/data/models/album.dart';
import 'package:muzzone/data/models/artist.dart';

part 'track.g.dart';

@HiveType(typeId: 1)
class Track {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String cover;
  @HiveField(4)
  final String file;
  @HiveField(5)
  final Album album;
  @HiveField(6)
  final List<Artist> artists;
  @HiveField(7)
  final String genres;
  @HiveField(8)
  final String audio;
  @HiveField(9)
  final int isPopular;
  @HiveField(10)
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
