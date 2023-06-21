part of 'audio_bloc.dart';

class AudioState {
  final bool isPlaying;
  final bool showMiniWidget;
  final PanelController panelController;
  final ScrollController scrollController;
  final bool closeMiniPlayer;
  final bool needChangeHeight;
  final double maxHeight;
  final double minHeight;
  final bool isPlayerOpen;
  final bool isDraggable;
  final bool isFavourite;
  final Audio? currentPlaying;
  final List<Audio>? favouriteAudios;

  AudioState({
    this.isPlaying = false,
    this.showMiniWidget = false,
    required this.panelController,
    required this.scrollController,
    this.closeMiniPlayer = false,
    this.needChangeHeight = true,
    this.maxHeight = 0.0,
    this.minHeight = 0.0,
    this.isPlayerOpen = false,
    this.isDraggable = true,
    this.isFavourite = false,
    this.currentPlaying,
    this.favouriteAudios,
  });

  AudioState copyWith({
    bool? isPlaying,
    bool? showMiniWidget,
    bool? closeMiniPlayer,
    bool? needChangeHeight,
    double? maxHeight,
    double? minHeight,
    bool? isPlayerOpen,
    bool? isDraggable,
    bool? isFavourite,
    Audio? currentPlaying,
    List<Audio>? favouriteAudios,
  }) {
    return AudioState(
      isPlaying: isPlaying ?? this.isPlaying,
      showMiniWidget: showMiniWidget ?? this.showMiniWidget,
      panelController: panelController,
      scrollController: scrollController,
      closeMiniPlayer: closeMiniPlayer ?? this.closeMiniPlayer,
      needChangeHeight: needChangeHeight ?? this.needChangeHeight,
      maxHeight: maxHeight ?? this.maxHeight,
      minHeight: minHeight ?? this.minHeight,
      isPlayerOpen: isPlayerOpen ?? this.isPlayerOpen,
      isDraggable: isDraggable ?? this.isDraggable,
      isFavourite: isFavourite ?? this.isFavourite,
      currentPlaying: currentPlaying ?? this.currentPlaying,
      favouriteAudios: favouriteAudios ?? this.favouriteAudios,
    );
  }
}

class AudioInitial extends AudioState {
  AudioInitial({
    required super.panelController,
    required super.scrollController,
  });
}
