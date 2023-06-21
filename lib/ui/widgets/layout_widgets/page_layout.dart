import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/ui/controllers/controllers.dart';
import 'package:muzzone/ui/widgets/common_widgets/bottom_offset.dart';

import '../../pages/player_page/bloc/audio_bloc.dart';

class PageLayout extends StatelessWidget {
  PageLayout({
    Key? key,
    this.child,
    this.children,
    this.needBottomBar = true,
    this.needMiniPlayer = true,
    this.withoutPhysics = false,
    this.needAnotherBottomHeight = false,
    this.noSingleScroll = false,
  }) : super(key: key);

  final bool needBottomBar;
  final Widget? child;
  final List<Widget>? children;
  final bool needMiniPlayer;
  final bool withoutPhysics;
  final bool needAnotherBottomHeight;
  final bool noSingleScroll;

  final con = GetIt.I.get<MainController>();
  final audioBloc = GetIt.I.get<AudioBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () {
            if (state.isPlayerOpen) {
              audioBloc.add(ClosePlayerWithButton());
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              width: double.infinity,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              child: noSingleScroll
                  ? child ??
                      Column(
                        children: [
                          for (var i in children!) i,
                          BottomOffset(
                            needAnotherHeight: needAnotherBottomHeight,
                          ),
                        ],
                      )
                  : SingleChildScrollView(
                      physics:
                          withoutPhysics ? null : const BouncingScrollPhysics(),
                      child: child ??
                          Column(
                            children: [
                              for (var i in children!) i,
                              BottomOffset(
                                needAnotherHeight: needAnotherBottomHeight,
                              ),
                            ],
                          ),
                    ),
            );
          }),
        );
      },
    );
  }
}
