import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzzone/config/constants/constants.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel/sliding_up_panel_event.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel/sliding_up_panel_state.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingUpPanelBloc extends Bloc<SlidingUpPanelEvent, SlidingUpPanelState> {
  final PanelController _panelController;

  SlidingUpPanelBloc({required PanelController panelController})
      : _panelController = panelController, super(SlidingUpPanelState(
    panelController: panelController,
  )) {
    on<OpenMiniPlayer>(_openMiniPlayer);
    on<CloseMiniPlayer>(_closeMiniPlayer);
    on<OpenSlidingPanel>(_openSlidingPanel);
    on<CloseSlidingPanel>(_closeSlidingPanel);
  }

  _openSlidingPanel(OpenSlidingPanel event, Emitter<SlidingUpPanelState> emitter) async {
    _panelController.open();
    return emitter(state.copyWith(
      isOpenSlidingUpPanel: true,
    ));
  }

  _closeSlidingPanel(CloseSlidingPanel event, Emitter<SlidingUpPanelState> emitter) async {
    _panelController.close();
    return emitter(state.copyWith(
      isOpenSlidingUpPanel: false,
    ));
  }

  _openMiniPlayer(OpenMiniPlayer event,
      Emitter<SlidingUpPanelState> emitter) async {

    return emitter(state.copyWith(
        minHeight: availableHeight / 8,
        maxHeight: availableHeight,));
  }

  _closeMiniPlayer(CloseMiniPlayer event,
      Emitter<SlidingUpPanelState> emitter) async {
    return emitter(state.copyWith(
        minHeight: 0,));
  }
}
