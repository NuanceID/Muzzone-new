import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/data/models/track.dart';

abstract class MyPlayListsEvent {
  const MyPlayListsEvent();
}

class GetMyPlayLists extends MyPlayListsEvent {
  const GetMyPlayLists();
}

class PutMyPlayList extends MyPlayListsEvent {
  final MyPlaylist myPlayList;

  const PutMyPlayList({required this.myPlayList});
}

class RemoveMyPlayList extends MyPlayListsEvent {
  final MyPlaylist myPlayList;

  const RemoveMyPlayList({required this.myPlayList});
}

class UpdateMyPlayListName extends MyPlayListsEvent {
  final MyPlaylist myPlayList;
  final String playListName;

  const UpdateMyPlayListName(
      {required this.myPlayList, required this.playListName});
}

class UpdateMyPlayListTrack extends MyPlayListsEvent {
  final MyPlaylist myPlayList;
  final Track track;

  const UpdateMyPlayListTrack({required this.myPlayList, required this.track});
}

class ValidateMyPlayListName extends MyPlayListsEvent {
  final bool isMyPlaylistNameValidated;

  const ValidateMyPlayListName({required this.isMyPlaylistNameValidated});
}
