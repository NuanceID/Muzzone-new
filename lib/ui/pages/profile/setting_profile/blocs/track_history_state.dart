part of 'track_history_bloc.dart';

class TrackHistoryState {
  final bool isOpen;

  TrackHistoryState({this.isOpen = false});

  TrackHistoryState copyWith({required bool isOpen}) {
    return TrackHistoryState(isOpen: isOpen);
  }
}
