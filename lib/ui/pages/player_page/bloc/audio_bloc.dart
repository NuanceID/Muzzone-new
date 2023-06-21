import 'dart:async';
import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/data/data.dart';
import 'package:muzzone/ui/controllers/controllers.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../config/style/style.dart';

part 'audio_event.dart';
part 'audio_state.dart';

final LocalDataStore _store = LocalDataStore();
final con = GetIt.I.get<MainController>();

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioBloc()
      : super(AudioInitial(
          panelController: PanelController(),
          scrollController: ScrollController(),
        )) {
    on<AudioEvent>((event, emit) {});
    on<StartPlaying>(_onStartPlaying);
    on<HideMiniWidget>(_onHideMiniWidget);
    on<ShowMiniWidget>(_onShowMiniWidget);
    on<CloseMiniPlayer>(_onCloseMiniPlayer);
    on<OpenMiniPlayer>(_onOpenMiniPlayer);
    on<BanChangeHeight>(_onBanChangeHeight);
    on<AllowChangeHeight>(_onAllowChangeHeight);
    on<ClosePlayerWithButton>(_onClosePlayerWithButton);
    on<OpenPlayer>(_onOpenPlayer);
    on<ClosePlayer>(_onClosePlayer);
    on<BanDrag>(_onBanDrag);
    on<AllowDrag>(_onAllowDrag);
    on<AddOrRemoveToFavourite>(_onAddOrRemoveToFavourite);
    on<CurrentPlaying>(_onCurrentPlaying);
    on<CloseAllForExitProfile>(_onCloseAllForExitProfile);
    on<ShowMinHeight>(_onShowMinHeight);
    on<HideMinHeight>(_onHideMinHeight);
    on<OpenController>(_onOpenController);
    // on<RemoveFromFavourite>(_onRemoveFromFavourite);
  }

  Future<List<Audio>> foo(List<int> list) async {
    List<Audio> tempList = [];
    for (var i = 0; i < con.audios.length; i++) {
      if (list.contains(int.parse(con.audios[i].metas.id!))) {
        tempList.add(con.audios[i]);
      }
    }

    return tempList;
  }

  FutureOr<void> _onStartPlaying(StartPlaying event, Emitter<AudioState> emit) {
    final List<Audio> favouriteList = [];
    for (var i = 0; i < event.playlist.length; i++) {
      if (_store
          .getFavouriteSongsList()
          .contains(int.parse(event.playlist[i].metas.id!))) {
        favouriteList.add(event.playlist[i]);
      }
    }
    emit(state.copyWith(favouriteAudios: favouriteList));
    log('FAVOURITE --- ${state.favouriteAudios}');
    emit(state.copyWith(
      isPlaying: true,
      showMiniWidget: false,
      maxHeight: Space.bottomBarHeight * 2,
      closeMiniPlayer: false,
    ));
  }

  FutureOr<void> _onHideMiniWidget(
      HideMiniWidget event, Emitter<AudioState> emit) {
    emit(state.copyWith(showMiniWidget: false));
  }

  FutureOr<void> _onShowMiniWidget(
      ShowMiniWidget event, Emitter<AudioState> emit) {
    emit(state.copyWith(showMiniWidget: true));
  }

  FutureOr<void> _onCloseMiniPlayer(
      CloseMiniPlayer event, Emitter<AudioState> emit) {
    emit(state.copyWith(closeMiniPlayer: true));
  }

  FutureOr<void> _onOpenMiniPlayer(
      OpenMiniPlayer event, Emitter<AudioState> emit) {
    emit(state.copyWith(closeMiniPlayer: false));
  }

  FutureOr<void> _onBanChangeHeight(
      BanChangeHeight event, Emitter<AudioState> emit) {
    emit(state.copyWith(needChangeHeight: false));
  }

  FutureOr<void> _onAllowChangeHeight(
      AllowChangeHeight event, Emitter<AudioState> emit) {
    emit(state.copyWith(needChangeHeight: true));
  }

  FutureOr<void> _onClosePlayerWithButton(
      ClosePlayerWithButton event, Emitter<AudioState> emit) {
    emit(state.copyWith(isPlayerOpen: false));
    state.panelController.animatePanelToPosition(0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutSine);
  }

  FutureOr<void> _onOpenPlayer(OpenPlayer event, Emitter<AudioState> emit) {
    emit(state.copyWith(isPlayerOpen: true));
  }

  FutureOr<void> _onClosePlayer(ClosePlayer event, Emitter<AudioState> emit) {
    emit(state.copyWith(isPlayerOpen: false));
  }

  FutureOr<void> _onBanDrag(BanDrag event, Emitter<AudioState> emit) {
    emit(state.copyWith(isDraggable: false));
  }

  FutureOr<void> _onAllowDrag(AllowDrag event, Emitter<AudioState> emit) {
    emit(state.copyWith(isDraggable: true));
  }

  FutureOr<void> _onAddOrRemoveToFavourite(
      AddOrRemoveToFavourite event, Emitter<AudioState> emit) {
    final list = _store.getFavouriteSongsList();
    if (list.contains(int.parse(state.currentPlaying!.metas.id!))) {
      list.remove(int.parse(state.currentPlaying!.metas.id!));
      emit(state.copyWith(isFavourite: false));
    } else {
      emit(state.copyWith(isFavourite: true));

      list.add(int.parse(event.myAudio.metas.id!));
    }
    _store.setFavouriteSongsList(list);
  }

  FutureOr<void> _onCurrentPlaying(
      CurrentPlaying event, Emitter<AudioState> emit) {
    Audio tempAudio = con.find(event.source, event.fromPath);
    emit(state.copyWith(currentPlaying: tempAudio));
    if (_store
        .getFavouriteSongsList()
        .contains(int.parse(tempAudio.metas.id!))) {
      emit(state.copyWith(isFavourite: true));
    } else {
      emit(state.copyWith(isFavourite: false));
    }
  }

  FutureOr<void> _onCloseAllForExitProfile(
      CloseAllForExitProfile event, Emitter<AudioState> emit) {
    emit(state.copyWith(minHeight: 0));
  }

  FutureOr<void> _onOpenController(
      OpenController event, Emitter<AudioState> emit) {
    emit(state.copyWith(minHeight: Space.bottomBarHeight * 2));
  }

  FutureOr<void> _onShowMinHeight(
      ShowMinHeight event, Emitter<AudioState> emit) {
    emit(state.copyWith(minHeight: Space.bottomBarHeight * 2));
  }

  FutureOr<void> _onHideMinHeight(
      HideMinHeight event, Emitter<AudioState> emit) {
    emit(state.copyWith(minHeight: 0));
  }
}
