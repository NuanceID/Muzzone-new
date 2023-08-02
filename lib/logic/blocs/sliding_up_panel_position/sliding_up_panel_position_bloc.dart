import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel_position/sliding_up_panel_position_event.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel_position/sliding_up_panel_position_state.dart';

class SlidingUpPanelPositionBloc
    extends Bloc<SlidingUpPanelPositionEvent, SlidingUpPanelPositionState> {
  SlidingUpPanelPositionBloc() : super(const SlidingUpPanelPositionState()) {
    on<SlidingPanelPosition>(_slidingPanelPosition);
  }

  _slidingPanelPosition(SlidingPanelPosition event,
      Emitter<SlidingUpPanelPositionState> emitter) async {
    return emitter(state.copyWith(
      position: event.position,
    ));
  }
}
