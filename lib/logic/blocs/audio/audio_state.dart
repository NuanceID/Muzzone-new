/*
import 'package:audio_service/audio_service.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AudioState extends Equatable {
  final AudioPlayer justAudioPlayer;
  final List<MediaItem> playlist;
  final bool isPlaying;
  final PanelController panelController;
  final double maxHeight;
  final double minHeight;
  final bool isOpenSlidePanel;

  const AudioState({
    required this.justAudioPlayer,
    this.playlist = const <MediaItem>[],
    this.isPlaying = false,
    required this.panelController,
    this.maxHeight = 0.0,
    this.minHeight = 0.0,
    this.isOpenSlidePanel = false,
  });

  @override
  List<Object> get props => [
        playlist,
        isPlaying,
        panelController,
        maxHeight,
        minHeight,
        isOpenSlidePanel
      ];

  AudioState copyWith(
      {List<MediaItem>? playlist,
      bool? isPlaying,
      double? maxHeight,
      double? minHeight,
      bool? isOpenSlidePanel}) {
    return AudioState(
        justAudioPlayer: justAudioPlayer,
        playlist: playlist ?? this.playlist,
        isPlaying: isPlaying ?? this.isPlaying,
        panelController: panelController,
        maxHeight: maxHeight ?? this.maxHeight,
        minHeight: minHeight ?? this.minHeight,
        isOpenSlidePanel: isOpenSlidePanel ?? this.isOpenSlidePanel);
  }
}
*/
