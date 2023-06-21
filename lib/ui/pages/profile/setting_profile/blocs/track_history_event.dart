part of 'track_history_bloc.dart';

@immutable
abstract class TrackHistoryEvent {}

class OpenTrackHistoryEvent extends TrackHistoryEvent {}

class CloseTrackHistoryEvent extends TrackHistoryEvent {}
