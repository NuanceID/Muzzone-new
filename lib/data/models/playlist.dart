import 'package:assets_audio_player/assets_audio_player.dart';

class MyPlaylist {
  final int id;
  final String title;
  final List<Audio> audios;
  final String image;
  final bool isGenre;
  final bool isAlbum;
  final bool isLanguage;
  final bool isBackendPlaylist;
  final bool isArtist;

  const MyPlaylist(
      {this.id = -1,
        this.title = '',
        this.audios = const <Audio>[],
        this.image = '',
        this.isGenre = false,
        this.isAlbum = false,
        this.isLanguage = false,
        this.isBackendPlaylist = false,
        this.isArtist = false,});
}
