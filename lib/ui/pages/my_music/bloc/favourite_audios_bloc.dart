import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:muzzone/data/data.dart';
import 'package:muzzone/ui/controllers/controllers.dart';

part 'favourite_audios_event.dart';
part 'favourite_audios_state.dart';

final LocalDataStore _store = LocalDataStore();
final con = GetIt.I.get<MainController>();

class FavouriteAudiosBloc
    extends Bloc<FavouriteAudiosEvent, FavouriteAudiosState> {
  FavouriteAudiosBloc() : super(FavouriteAudiosInitial(favouriteList: [])) {
    on<LoadFavouriteAudiosEvent>(_onLoadFavouriteAudiosEvent);
    on<AddOrRemoveEvent>(_onAddOrRemoveEvent);
  }

  FutureOr<void> _onLoadFavouriteAudiosEvent(LoadFavouriteAudiosEvent event,
      Emitter<FavouriteAudiosState> emit) async {
    List<Audio> newFavouriteList = [];

    for (var i = 0; i < con.audios.length; i++) {
      if (_store
          .getFavouriteSongsList()
          .contains(int.parse(con.audios[i].metas.id!))) {
        newFavouriteList.add(con.audios[i]);
      }
    }
    emit(state.copyWith(favouriteList: newFavouriteList));
  }

  FutureOr<void> _onAddOrRemoveEvent(
      AddOrRemoveEvent event, Emitter<FavouriteAudiosState> emit) {
    final listStorage = _store.getFavouriteSongsList();
    List<Audio> newFavouriteList = state.favouriteList;
    if (listStorage.contains(event.id)) {
      listStorage.remove(event.id);
      final Audio minus = newFavouriteList
          .firstWhere((element) => int.parse(element.metas.id!) == event.id);
      newFavouriteList.remove(minus);
    } else {
      final Audio plus = con.audios
          .firstWhere((element) => int.parse(element.metas.id!) == event.id);
      newFavouriteList.add(plus);
      listStorage.add(event.id);
    }
    _store.setFavouriteSongsList(listStorage);
    emit(state.copyWith(favouriteList: newFavouriteList));
  }
}
