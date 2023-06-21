import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../config/style/style.dart';
import '../../../logic/blocs/bottom_bar/bottom_bar_bloc.dart';
import '../../pages/player_page/bloc/audio_bloc.dart';
import '../../pages/player_page/view/player_page.dart';
import 'bottom_player_widget.dart';

class MySlidingUpPanel extends StatelessWidget {
  MySlidingUpPanel({Key? key, required this.child, required this.kNavigatorKey})
      : super(key: key);

  final Widget? child;
  final GlobalKey<NavigatorState> kNavigatorKey;

  final bottomBarBloc = GetIt.I.get<BottomBarBloc>();

  final audioBloc = GetIt.I.get<AudioBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        return SlidingUpPanel(
          backdropEnabled: false,
          panelSnapping: true,
          isDraggable: state.isDraggable,
          borderRadius: state.closeMiniPlayer
              ? null
              : const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          defaultPanelState: PanelState.CLOSED,
          controller: state.panelController,
          minHeight: state.minHeight,
          maxHeight: 100.h,
          body: child ?? Container(),
          panelBuilder: (sc) =>
              PlayerPage(scrollController: state.scrollController),
          header: state.closeMiniPlayer
              ? Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  height: 3.h,
                  width: 100.w,
                )
              : BottomPlayerWidget(
                  onPress: () {
                    log('Tap on miniplayer');
                    state.panelController.animatePanelToPosition(1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOutSine);
                  },
                ),
          onPanelOpened: _onPlayerOpened,
          onPanelClosed: _onPlayerClosed,
          onPanelSlide: (details) => _onPlayerSlide(details, state),
        );
      },
    );
  }

  void _onPlayerClosed() {
    audioBloc.add(ClosePlayer());
    audioBloc.add(OpenMiniPlayer());
    audioBloc.add(AllowChangeHeight());
  }

  void _onPlayerOpened() {
    audioBloc.add(OpenPlayer());
    audioBloc.add(CloseMiniPlayer());
    audioBloc.add(BanChangeHeight());
    bottomBarBloc.add(HideBottomBar());
    bottomBarBloc.add(ChangeHeightBottomBar(newHeight: 100));
  }

  void _onPlayerSlide(double details, AudioState state) {
    if (details == 1) {
      bottomBarBloc.add(HideBottomBar());
    } else if (details < 0.99) {
      bottomBarBloc.add(ShowBottomBar());
    }
    if (state.needChangeHeight) {
      bottomBarBloc.add(ChangeHeightBottomBar(
          newHeight: Space.bottomBarHeight - Space.bottomBarHeight * details));
    } else {
      bottomBarBloc.add(ChangeHeightBottomBar(
          newHeight: Space.bottomBarHeight - Space.bottomBarHeight * details));
    }

    if (details > 0.05) {
      audioBloc.add(CloseMiniPlayer());
    } else {
      audioBloc.add(OpenMiniPlayer());
    }
  }
}
