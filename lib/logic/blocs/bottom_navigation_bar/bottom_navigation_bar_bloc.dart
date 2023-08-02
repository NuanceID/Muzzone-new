import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzzone/logic/blocs/bottom_navigation_bar/bottom_navigation_bar_event.dart';
import 'package:muzzone/logic/blocs/bottom_navigation_bar/bottom_navigation_bar_state.dart';

class BottomNavigationBarBloc
    extends Bloc<BottomNavigationBarEvent, BottomNavigationBarState> {
  BottomNavigationBarBloc() : super(const BottomNavigationBarState()) {
    on<SelectedBottomNavBarItem>(_slidingPanelPosition);
    on<SetTabController>(_setTabController);
  }

  _slidingPanelPosition(SelectedBottomNavBarItem event,
      Emitter<BottomNavigationBarState> emitter) async {
    return emitter(state.copyWith(
      index: event.index,
    ));
  }

  _setTabController(
      SetTabController event, Emitter<BottomNavigationBarState> emitter) async {
    return emitter(state.copyWith(
      tabController: event.tabController,
    ));
  }
}
