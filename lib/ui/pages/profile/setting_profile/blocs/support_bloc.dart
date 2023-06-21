import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'support_event.dart';
part 'support_state.dart';

class SupportBloc extends Bloc<SupportEvent, SupportState> {
  SupportBloc() : super(SupportInitial(isOpen: false)) {
    on<SupportEvent>((event, emit) {});
    on<OpenSupportEvent>(_onOpenSupport);
    on<CloseSupportEvent>(_onCloseSupport);
  }

  FutureOr<void> _onOpenSupport(
      OpenSupportEvent event, Emitter<SupportState> emit) {
    emit(state.copyWith(isOpen: true));
  }

  FutureOr<void> _onCloseSupport(
      CloseSupportEvent event, Emitter<SupportState> emit) {
    emit(state.copyWith(isOpen: false));
  }
}
