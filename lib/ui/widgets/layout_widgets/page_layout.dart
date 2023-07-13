/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/ui/controllers/controllers.dart';

import '../../pages/player_page/bloc/audio_bloc.dart';

class PageLayout extends StatelessWidget {
  PageLayout({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget>? children;

  final con = GetIt.I.get<MainController>();
  final audioBloc = GetIt.I.get<AudioBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        return WillPopScope(onWillPop: () async {
          if (state.isPlayerOpen) {
            audioBloc.add(ClosePlayerWithButton());
            return false;
          } else {
            return true;
          }
        }, child: );
      },
    );
  }
}
*/
