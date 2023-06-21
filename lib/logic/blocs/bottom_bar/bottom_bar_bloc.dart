import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_bar_event.dart';
part 'bottom_bar_state.dart';

class BottomBarBloc extends Bloc<BottomBarEvent, BottomBarState> {
  BottomBarBloc()
      : super(BottomBarInitial(
          activeIndex: 0,
          canUse: true,
          height: 0,
        )) {
    on<BottomBarEvent>((event, emit) {});
    on<ChangeBottomBarItemEvent>(_onChangeBottomBarEvent);
    on<HideBottomBar>(_onHideBottomBar);
    on<ShowBottomBar>(_onShowBottomBar);
    on<ChangeHeightBottomBar>(_onChangeHeightBottomBar);
  }

  FutureOr<void> _onChangeBottomBarEvent(
      ChangeBottomBarItemEvent event, Emitter<BottomBarState> emit) {
    emit(state.copyWith(activeIndex: event.newActiveIndex, canUse: true));
  }

  FutureOr<void> _onHideBottomBar(
      HideBottomBar event, Emitter<BottomBarState> emit) {
    emit(state.copyWith(visible: false));
  }

  FutureOr<void> _onShowBottomBar(
      ShowBottomBar event, Emitter<BottomBarState> emit) {
    emit(state.copyWith(visible: true));
  }

  FutureOr<void> _onChangeHeightBottomBar(
      ChangeHeightBottomBar event, Emitter<BottomBarState> emit) {
    emit(state.copyWith(height: event.newHeight));
  }
}
