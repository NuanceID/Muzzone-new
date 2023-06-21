import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:muzzone/data/data.dart';

class MainController extends ChangeNotifier {
  var audios = <Audio>[
    /*Audio.network(
      'https://cdn.pixabay.com/download/audio/2022/01/20/audio_f1b4f4c8b1.mp3?filename=welcome-to-the-games-15238.mp3',
      metas: Metas(
        id: '8432',
        title: 'Welcome Here',
        artist: 'Ansh Rathod',
        album: 'OnlineAlbum',
        extra: {
          'isPopular': true,
          'isNew': false,
        },
        image: const MetasImage.network(
            'https://images.unsplash.com/photo-1611339555312-e607c8352fd7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
      ),
    ),
    Audio.network(
      LocalSongsRepository.localSongs[0].audio,
      metas: Metas(
        id: LocalSongsRepository.localSongs[0].id.toString(),
        title: LocalSongsRepository.localSongs[0].name,
        artist: LocalSongsRepository.localSongs[0].artists,
        album: LocalSongsRepository.localSongs[0].album,
        extra: {
          'isPopular': false,
          'isNew': true,
        },
        image: const MetasImage.network(
            'https://upl.uz/uploads/posts/2021-08/1630148255_1613926133_snimok-ekrana-2020-12-30-v-22_49_04-768x441-min.png'),
      ),
    ),
    Audio.network(
      LocalSongsRepository.localSongs[1].audio,
      metas: Metas(
        id: LocalSongsRepository.localSongs[1].id.toString(),
        title: LocalSongsRepository.localSongs[1].name,
        artist: LocalSongsRepository.localSongs[1].artists,
        album: LocalSongsRepository.localSongs[1].album,
        extra: {
          'isPopular': false,
          'isNew': false,
        },
        image: const MetasImage.network(
            'https://cdnn1.img.sputnik.tj/img/07e6/01/14/1044968308_0:0:478:478_1920x0_80_0_0_9d807daefb1e7b77d29d8f1a91349de5.png'),
      ),
    ),
    Audio.network(
      LocalSongsRepository.localSongs[2].audio,
      metas: Metas(
        id: LocalSongsRepository.localSongs[2].id.toString(),
        title: LocalSongsRepository.localSongs[2].name,
        artist: LocalSongsRepository.localSongs[2].artists,
        album: LocalSongsRepository.localSongs[2].album,
        extra: {
          'isPopular': true,
          'isNew': true,
        },
        image: const MetasImage.network(
            'https://tbld.uz/wp-content/uploads/2021/01/eshhshh.png'),
      ),
    ),
    Audio.network(
      LocalSongsRepository.localSongs[3].audio,
      metas: Metas(
        id: LocalSongsRepository.localSongs[3].id.toString(),
        title: LocalSongsRepository.localSongs[3].name,
        artist: LocalSongsRepository.localSongs[3].artists,
        album: LocalSongsRepository.localSongs[3].album,
        image: const MetasImage.network(
            'https://cdnn1.img.sputniknews-uz.com/img/1270/16/12701668_420:0:1500:1080_1920x0_80_0_0_62e847ef33ce3cac9b1356c30c00d643.png'),
      ),
    ),*/
  ];
  bool isNext = true;
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('Playing audio');
  bool isPlaying = false;

  final List<StreamSubscription> _subscriptions = [];
  List<dynamic> getRecentlyPlayed() {
    List<dynamic> data = [];
    var box = Hive.box('RecentlyPlayed');
    for (var i = 0; i < box.length; i++) {
      data.add(box.getAt(i));
    }
    return data;
  }

  List<Audio> converLocalSongToAudio(songs) {
    return (songs as List).map((audio) {
      return Audio.network(audio['track'],
          metas: Metas(
            id: audio['id'],
            title: audio['songname'],
            artist: audio['fullname'],
            album: audio['username'],
            image: MetasImage.network(audio['cover']),
          ));
    }).toList();
  }

  void init() async {
    _subscriptions.add(player.playlistAudioFinished.listen((data) async {
      final myAudio = data.playlist.audios[data.playlist.currentIndex];
      var box = Hive.box('RecentlyPlayed');
      await box.put(myAudio.metas.title, {
        "songname": myAudio.metas.title,
        "fullname": myAudio.metas.artist,
        "username": myAudio.metas.album,
        "cover": myAudio.metas.image!.path,
        "track": myAudio.path,
        "id": myAudio.metas.id,
        "created": DateTime.now().toString(),
      });
    }));

    _subscriptions.add(player.audioSessionId.listen((sessionId) {}));
    _subscriptions
        .add(AssetsAudioPlayer.addNotificationOpenAction((notification) {
      return false;
    }));
    final recentSongs = getRecentlyPlayed();
    recentSongs.sort((a, b) => b["created"].compareTo(a["created"]));
    if (recentSongs.isNotEmpty) {
      if (audios.isNotEmpty) {
        audios.removeAt(0);
      }
    }
    converLocalSongToAudio(recentSongs).forEach((audio) {
      audios.add(audio);
    });
    await openPlayer(newList: audios);
  }

  void addToFavorite(
      {required String name,
      required String fullname,
      required String username,
      required String cover,
      required String track}) {
    // var box = Hive.box('liked');

    // box.put(name, {
    //   "songname": name,
    //   "fullname": fullname,
    //   "username": username,
    //   "cover": cover,
    //   "track": track
    // });
  }

  Future<void> openPlayer(
      {required List<Audio> newList, int initial = 0}) async {
    await player.open(Playlist(audios: newList, startIndex: initial),
        showNotification: true,
        autoStart: false,
        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
        notificationSettings: const NotificationSettings(
          stopEnabled: false,
        ));

    notifyListeners();
  }

  void playSong(List<Audio> newPlaylist, int initial) async {
    isPlaying = true;
    if (isNext) {
      isNext = false;
      await player.pause();
      await player.stop();
      audios = newPlaylist;
      await openPlayer(newList: newPlaylist, initial: initial);
      await player.play();
      isNext = true;
    }
  }

  void changeIndex(int newIndex, int oldIndex) {
    player.playlist!.audios
        .insert(newIndex, player.playlist!.audios.removeAt(oldIndex));

    notifyListeners();
  }

  void close() {
    player.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  Audio findByName(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.metas.title == fromPath);
  }

  List<Audio> convertToAudio(List<SongModel> songs) {
    return [
      ...songs.map((audio) {
        return Audio.network(audio.trackid!,
            metas: Metas(
              id: audio.songid,
              title: audio.songname,
              artist: audio.name,
              album: audio.userid,
              image: MetasImage.network(audio.coverImageUrl!),
            ));
      }).toList()
    ];
  }
}
