import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'track_history_event.dart';
part 'track_history_state.dart';

class TrackHistoryBloc extends Bloc<TrackHistoryEvent, TrackHistoryState> {
  TrackHistoryBloc() : super(TrackHistoryInitial(isOpen: false)) {
    on<TrackHistoryEvent>((event, emit) {});
    on<OpenTrackHistoryEvent>(_onOpenTrackHistory);
    on<CloseTrackHistoryEvent>(_onCloseTrackHistory);
  }

  FutureOr<void> _onOpenTrackHistory(
      TrackHistoryEvent event, Emitter<TrackHistoryState> emit) {
    emit(state.copyWith(isOpen: true));
  }

  FutureOr<void> _onCloseTrackHistory(
      CloseTrackHistoryEvent event, Emitter<TrackHistoryState> emit) {
    emit(state.copyWith(isOpen: false));
  }
}
