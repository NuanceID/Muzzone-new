import 'package:audio_service/audio_service.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/logic/blocs/my_playlists/my_playlists_event.dart';
import 'package:muzzone/logic/blocs/my_playlists/my_playlists_state.dart';

class MyPlayListsBloc extends Bloc<MyPlayListsEvent, MyPlayListsState> {
  MyPlayListsBloc() : super(const MyPlayListsState()) {
    on<GetMyPlayLists>(_getMyPlayLists);
    on<PutMyPlayList>(_putMyPlayList);
    on<RemoveMyPlayList>(_removeMyPlayList);
    on<UpdateMyPlayListName>(_updateMyPlayListName);
    on<UpdateMyPlayListTrack>(_updateMyPlayListTrack);
    on<ValidateMyPlayListName>(_validateMyPlayListName);
  }

  _getMyPlayLists(
      GetMyPlayLists event, Emitter<MyPlayListsState> emitter) async {
    emitter(state.copyWith(myPlayListsStatus: MyPlayListsStatus.loading));

    var box = Hive.box<MyPlaylist>('myPlayLists');

    return emitter(state.copyWith(
        myPlayListsStatus: MyPlayListsStatus.success,
        myPlayLists: box.values.reversed.toList()));
  }

  _putMyPlayList(PutMyPlayList event, Emitter<MyPlayListsState> emitter) async {
    var box = Hive.box<MyPlaylist>('myPlayLists');

    if (box.length < 100) {
      box.put(event.myPlayList.uuid, event.myPlayList);
    } else {
      box.deleteAt(100);
      box.put(event.myPlayList.uuid, event.myPlayList);
    }

    return emitter(state.copyWith(
        myPlayListsStatus: MyPlayListsStatus.success,
        myPlayLists: box.values.reversed.toList()));
  }

  _removeMyPlayList(
      RemoveMyPlayList event, Emitter<MyPlayListsState> emitter) async {
    var box = Hive.box<MyPlaylist>('myPlayLists');

    await box.delete(event.myPlayList.uuid);

    return emitter(state.copyWith(
        myPlayListsStatus: MyPlayListsStatus.success,
        myPlayLists: box.values.reversed.toList()));
  }

  _updateMyPlayListName(
      UpdateMyPlayListName event, Emitter<MyPlayListsState> emitter) async {
    var box = Hive.box<MyPlaylist>('myPlaylists');

    var myPlayList = box.get(event.myPlayList.uuid);

    MyPlaylist? updatedMyPlayList;
    if (myPlayList != null) {
      updatedMyPlayList = MyPlaylist(
          id: myPlayList.id,
          title: event.playListName,
          audios: myPlayList.audios,
          image: myPlayList.image,
          isGenre: myPlayList.isGenre,
          isAlbum: myPlayList.isAlbum,
          isLanguage: myPlayList.isLanguage,
          isBackendPlaylist: myPlayList.isBackendPlaylist,
          isArtist: myPlayList.isArtist,
          isMyPlayList: myPlayList.isMyPlayList,
          uuid: myPlayList.uuid);

      box.put(event.myPlayList.uuid, updatedMyPlayList);
    }

    return emitter(state.copyWith(
        myPlayListsStatus: MyPlayListsStatus.success,
        myPlayLists: box.values.reversed.toList()));
  }

  _updateMyPlayListTrack(
      UpdateMyPlayListTrack event, Emitter<MyPlayListsState> emitter) async {
    var box = Hive.box<MyPlaylist>('myPlaylists');

    var myPlayList = box.get(event.myPlayList.uuid);

    MyPlaylist? updatedMyPlayList;
    if (myPlayList != null) {
      updatedMyPlayList = MyPlaylist(
          id: myPlayList.id,
          title: myPlayList.title,
          audios: List.from(myPlayList.audios)
            ..addAll([
              MediaItem(
                id: event.track.file,
                title: event.track.name,
                album: event.track.album.name,
                artist: event.track.artists
                    .map((element) => element.name)
                    .toList()
                    .join(', '),
                artUri: Uri.parse(event.track.cover),
              )
            ]),
          image: myPlayList.image,
          isGenre: myPlayList.isGenre,
          isAlbum: myPlayList.isAlbum,
          isLanguage: myPlayList.isLanguage,
          isBackendPlaylist: myPlayList.isBackendPlaylist,
          isArtist: myPlayList.isArtist,
          isMyPlayList: myPlayList.isMyPlayList,
          uuid: myPlayList.uuid);

      box.put(event.myPlayList.uuid, updatedMyPlayList);
    }

    return emitter(state.copyWith(
        myPlayListsStatus: MyPlayListsStatus.success,
        myPlayLists: box.values.reversed.toList()));
  }

  _validateMyPlayListName(
      ValidateMyPlayListName event, Emitter<MyPlayListsState> emitter) async {
    return emitter(state.copyWith(
        isMyPlayListNameValidated: event.isMyPlaylistNameValidated));
  }
}
