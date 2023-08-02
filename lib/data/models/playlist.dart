import 'package:audio_service/audio_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'playlist.g.dart';

@HiveType(typeId: 2)
class MyPlaylist {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final List<MediaItem> audios;
  @HiveField(3)
  final String image;
  @HiveField(4)
  final bool isGenre;
  @HiveField(5)
  final bool isAlbum;
  @HiveField(6)
  final bool isLanguage;
  @HiveField(7)
  final bool isBackendPlaylist;
  @HiveField(8)
  final bool isArtist;
  @HiveField(9)
  final bool isMyPlayList;
  @HiveField(10)
  final String uuid;

  const MyPlaylist({
    this.id = -1,
    this.title = '',
    this.audios = const <MediaItem>[],
    this.image = '',
    this.isGenre = false,
    this.isAlbum = false,
    this.isLanguage = false,
    this.isBackendPlaylist = false,
    this.isArtist = false,
    this.uuid = '',
    this.isMyPlayList = false,
  });
}
