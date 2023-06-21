import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/config/config.dart';
import 'package:sizer/sizer.dart';

import '../pages/player_page/bloc/audio_bloc.dart';
import 'controllers.dart';

class BottomPlayingController extends StatelessWidget {
  BottomPlayingController({
    Key? key,
    required this.con,
    required this.onPlay,
    required this.isPlaying,
    required this.isPlaylist,
    required this.addToFavourite,
  }) : super(key: key);

  final MainController con;
  final bool isPlaying;
  final Function() onPlay;
  final Function() addToFavourite;
  final bool isPlaylist;

  final audioBloc = GetIt.I.get<AudioBloc>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<AudioBloc, AudioState>(
          builder: (context, state) {
            return IconButton(
              onPressed: addToFavourite,
              icon: SvgPicture.asset(
                state.isFavourite
                    ? '${iconsPath}like_full.svg'
                    : '${iconsPath}like.svg',
                color: state.isFavourite
                    ? AppColors.primaryColor
                    : Theme.of(context).cardColor,
              ),
            );
          },
        ),
        SizedBox(
          width: 0.w,
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            '${iconsPath}like_add.svg',
            color: Theme.of(context).cardColor,
          ),
        ),
        SizedBox(
          width: 0.w,
        ),
        IconButton(
          onPressed: () {
            con.player.playOrPause();
          },
          icon: SvgPicture.asset(
            isPlaying ? '${iconsPath}pause.svg' : '${iconsPath}play.svg',
            color: Theme.of(context).cardColor,
          ),
        ),
      ],
    );
  }
}
