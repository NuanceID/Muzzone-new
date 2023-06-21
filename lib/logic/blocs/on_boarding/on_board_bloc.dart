import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';

import '../../../generated/locale_keys.g.dart';

part 'on_board_event.dart';
part 'on_board_state.dart';

class OnBoardBloc extends Bloc<OnBoardEvent, OnBoardState> {
  OnBoardBloc() : super(OnBoardInitial(title: LocaleKeys.button_start.tr())) {
    on<OnBoardEvent>((event, emit) {});
    on<OnboardChangeEvent>(_onOnboardChangeEvent);
  }

  FutureOr<void> _onOnboardChangeEvent(
      OnboardChangeEvent event, Emitter<OnBoardState> emit) {
    emit(state.copyWith(
        title: event.buttonName, currentPage: event.currentPage));
  }
}
