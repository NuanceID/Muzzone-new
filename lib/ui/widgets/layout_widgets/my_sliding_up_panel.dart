import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzzone/config/constants/constants.dart';
import 'package:muzzone/logic/blocs/audio/audio_state.dart';
import 'package:muzzone/ui/widgets/layout_widgets/bottom_player_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../logic/blocs/audio/audio_bloc.dart';
import '../../pages/player_page/view/player_page.dart';

class MySlidingUpPanel extends StatelessWidget {
  const MySlidingUpPanel({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        return SlidingUpPanel(
          backdropEnabled: false,
          panelSnapping: true,
          defaultPanelState: PanelState.CLOSED,
          controller: state.panelController,
          minHeight: state.minHeight,
          maxHeight: state.maxHeight,
          body: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            body: Column(
              children: [
                Flexible(child: child),
                Container(
                  height: availableHeight / 20,
                ),
                Container(
                  height: state.minHeight,
                )
              ],
            ),
          ),
          panel: state.minHeight != 0.0 ? const PlayerPage() : Container(),
          collapsed: state.minHeight != 0.0 ? BottomPlayerWidget(
            onPress: () {
              state.panelController.animatePanelToPosition(1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutSine);
            },
          ) : null,
        );
      },
    );
  }
}
