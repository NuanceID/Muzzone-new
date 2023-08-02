import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/config/routes/muzzone_nested_routes.dart';
import 'package:muzzone/data/local_data_store/local_data_store.dart';
import 'package:muzzone/generated/locale_keys.g.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel/sliding_up_panel_bloc.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel/sliding_up_panel_event.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel/sliding_up_panel_state.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel_position/sliding_up_panel_position_bloc.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel_position/sliding_up_panel_position_event.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel_position/sliding_up_panel_position_state.dart';
import 'package:muzzone/ui/pages/main_page/widgets/main_menu_buttons.dart';
import 'package:muzzone/ui/pages/main_page/widgets/player_menu_buttons.dart';
import 'package:muzzone/ui/pages/tabbar_view/tabbar_view_page.dart';
import 'package:muzzone/ui/widgets/layout_widgets/bottom_player_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../pages/player_page/view/player_page.dart';

class MySlidingUpPanel extends StatefulWidget {
  const MySlidingUpPanel({super.key, required this.mainRoute});

  final String mainRoute;

  @override
  State<MySlidingUpPanel> createState() => _MySlidingUpPanelState();
}

class _MySlidingUpPanelState extends State<MySlidingUpPanel> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SlidingUpPanelBloc, SlidingUpPanelState>(
      builder: (context, state) {
        return WillPopScope(
            onWillPop: () async {
              if (BlocProvider.of<SlidingUpPanelBloc>(context)
                  .state
                  .panelController
                  .isPanelOpen) {
                BlocProvider.of<SlidingUpPanelBloc>(context)
                    .add(CloseSlidingPanel());
                return false;
              }

              if (Globals.kNestedNavigatorKey.currentState != null) {
                Globals.kNestedNavigatorKey.currentState?.maybePop();
                return false;
              }

              LocalDataStore store = LocalDataStore();

              DateTime now = DateTime.now();

              if (store.getDurationTimeBetweenPress().isEmpty) {
                store.setDurationTimeBetweenPress(now.toString());
                showFlutterToast(AppColors.primaryColor, Colors.white,
                    LocaleKeys.repeat_tap_to_exit.tr());
                return false;
              }

              if (now
                      .difference(
                          DateTime.parse(store.getDurationTimeBetweenPress()))
                      .inSeconds <
                  4) {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              } else {
                store.setDurationTimeBetweenPress(now.toString());
                showFlutterToast(AppColors.primaryColor, Colors.white,
                    LocaleKeys.repeat_tap_to_exit.tr());
              }
              return false;
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SlidingUpPanel(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r),
                ),
                backdropEnabled: false,
                panelSnapping: true,
                defaultPanelState: PanelState.CLOSED,
                controller: state.panelController,
                minHeight: state.minHeight,
                maxHeight: state.maxHeight,
                body: Column(
                  children: [
                    const Flexible(child: TabBarViewPage()),
                    Container(
                      color: Colors.transparent,
                      height: availableHeight / 12 + availableHeight / 30,
                    ),
                    Container(
                      color: Colors.transparent,
                      height: state.minHeight,
                    )
                  ],
                ),
                panel:
                    state.minHeight != 0.0 ? const PlayerPage() : Container(),
                collapsed: state.minHeight != 0.0
                    ? Focus(
                        autofocus: true,
                        child: BottomPlayerWidget(
                          onPress: () {
                            state.panelController.animatePanelToPosition(1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOutSine);
                          },
                        ))
                    : null,
                onPanelSlide: (position) {
                  BlocProvider.of<SlidingUpPanelPositionBloc>(context)
                      .add(SlidingPanelPosition(position: position));
                },
              ),
              bottomNavigationBar: Container(
                height: availableHeight / 12,
                decoration: const BoxDecoration(color: Colors.white),
                child: Stack(
                  children: [
                    Positioned.fill(child: BlocBuilder<
                        SlidingUpPanelPositionBloc,
                        SlidingUpPanelPositionState>(
                      builder: (context, slidingUpPanelPositionState) {
                        var currentPosition =
                            2 * slidingUpPanelPositionState.position;

                        if (slidingUpPanelPositionState.position >= 0.5) {
                          return const SizedBox.shrink();
                        }

                        return Opacity(
                            opacity: slidingUpPanelPositionState.position <= 0
                                ? 1
                                : slidingUpPanelPositionState.position >= 0.5
                                    ? 0
                                    : 1 - currentPosition,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: state.minHeight == 0.0
                                          ? Colors.grey.withOpacity(0.2)
                                          : Colors.transparent,
                                      spreadRadius: 2.r,
                                      blurRadius: 2.r,
                                      offset: const Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: const MainMenuButtons()));
                      },
                    )),
                    Positioned.fill(child: BlocBuilder<
                        SlidingUpPanelPositionBloc,
                        SlidingUpPanelPositionState>(
                      builder: (context, slidingUpPanelPositionState) {
                        var currentPosition =
                            2 * slidingUpPanelPositionState.position;

                        if (slidingUpPanelPositionState.position == 0) {
                          return const SizedBox.shrink();
                        }

                        var oldRange = 1 - 0;
                        var newRange = 0.2 - 0;

                        var newValue =
                            (((slidingUpPanelPositionState.position - 0) *
                                    newRange) /
                                oldRange);

                        return Opacity(
                            opacity: currentPosition <= 0.5
                                ? 0
                                : currentPosition >= 1
                                    ? 1
                                    : currentPosition - 0.45,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: state.minHeight != 0.0
                                          ? Colors.grey.withOpacity(newValue)
                                          : Colors.transparent,
                                      spreadRadius: 2.r,
                                      blurRadius: 2.r,
                                      offset: const Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: const PlayerMenuButtons()));
                      },
                    ))
                  ],
                ),
              ),
            ));
      },
    );
  }
}
