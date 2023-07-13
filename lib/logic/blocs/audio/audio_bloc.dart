/*
import 'package:audio_service/audio_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:muzzone/config/constants/constants.dart';
import 'package:muzzone/logic/blocs/audio/audio_event.dart';
import 'package:muzzone/logic/blocs/audio/audio_state.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {

  final AudioPlayer _justAudioPlayer;
  final PanelController _panelController;

  AudioBloc({required AudioPlayer justAudioPlayer, required PanelController panelController})
      : _justAudioPlayer = justAudioPlayer, _panelController = panelController, super(AudioState(
    justAudioPlayer: justAudioPlayer,
    panelController: panelController,
  )) {
    on<Play>(_play);
    on<Pause>(_pause);
    on<SetPlaylist>(_setPlaylist);
    on<ClearPlaylist>(_clearPlaylist);
    on<CloseMiniPlayer>(_closeMiniPlayer);
    on<OpenMiniPlayer>(_openMiniPlayer);
    on<PlayOrPause>(_playOrPause);
    on<OpenSlidingPanel>(_openSlidingPanel);
    on<CloseSlidingPanel>(_closeSlidingPanel);
  }

  _openSlidingPanel(OpenSlidingPanel event, Emitter<AudioState> emitter) async {
    _panelController.open();
    return emitter(state.copyWith(
      isOpenSlidePanel: true,
    ));
  }

  _closeSlidingPanel(CloseSlidingPanel event, Emitter<AudioState> emitter) async {
    _panelController.close();
    return emitter(state.copyWith(
      isOpenSlidePanel: false,
    ));
  }

  _play(Play event, Emitter<AudioState> emitter) async {
    var audio = _justAudioPlayer.playlist?.audios.firstWhereOrNull((element) => element.path == event.audioPath);

    int? index;
    if(audio != null) {
      index = _justAudioPlayer.playlist?.audios.indexOf(audio);
    }

    if(index != null) {
      await _justAudioPlayer.stop();
      await _justAudioPlayer.playlistPlayAtIndex(index);

      return emitter(state.copyWith(
        isPlaying: true,
      ));
    }
  }

  _pause(Pause event, Emitter<AudioState> emitter) async {
    await _justAudioPlayer.pause();
    return emitter(state.copyWith(
      isPlaying: false,
    ));
  }

  _setPlaylist(SetPlaylist event, Emitter<AudioState> emitter) async {

    await _justAudioPlayer.open(
        Playlist(audios: List.from(state.playlist)..addAll(event.playlist)),
        showNotification: true,
        autoStart: false,
        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
        notificationSettings: const NotificationSettings(
          stopEnabled: false,
        ));

    return emitter(state.copyWith(
        playlist: event.playlist
    ));
  }

  _clearPlaylist(ClearPlaylist event, Emitter<AudioState> emitter) async {
    return emitter(state.copyWith(
        playlist: <MediaItem>[]
    ));
  }

  _closeMiniPlayer(CloseMiniPlayer event,
      Emitter<AudioState> emitter) async {
    return emitter(state.copyWith(
        minHeight: 0,));
  }

  _openMiniPlayer(OpenMiniPlayer event,
      Emitter<AudioState> emitter) async {

    return emitter(state.copyWith(
        minHeight: availableHeight / 8,
        maxHeight: availableHeight,));
  }

  _playOrPause(PlayOrPause event, Emitter<AudioState> emitter) async {
    _justAudioPlayer.playOrPause();

    return emitter(state.copyWith(
      isPlaying: _justAudioPlayer.isPlaying.value,
    ));
  }
}
*/
