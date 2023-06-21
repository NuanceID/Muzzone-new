part of 'audio_bloc.dart';

abstract class AudioEvent {}

class StartPlaying extends AudioEvent {
  final List<Audio> playlist;

  StartPlaying(this.playlist);
}

class HideMiniWidget extends AudioEvent {}

class ShowMiniWidget extends AudioEvent {}

class CloseMiniPlayer extends AudioEvent {}

class OpenMiniPlayer extends AudioEvent {}

class BanChangeHeight extends AudioEvent {}

class AllowChangeHeight extends AudioEvent {}

class ClosePlayerWithButton extends AudioEvent {}

class OpenPlayer extends AudioEvent {}

class ClosePlayer extends AudioEvent {}

class BanDrag extends AudioEvent {}

class AllowDrag extends AudioEvent {}

class AddOrRemoveToFavourite extends AudioEvent {
  final Audio myAudio;

  AddOrRemoveToFavourite(this.myAudio);
}

class CurrentPlaying extends AudioEvent {
  List<Audio> source;
  String fromPath;

  CurrentPlaying(this.source, this.fromPath);
}

class CloseAllForExitProfile extends AudioEvent {}

class OpenController extends AudioEvent {}

class ShowMinHeight extends AudioEvent {}

class HideMinHeight extends AudioEvent {}
