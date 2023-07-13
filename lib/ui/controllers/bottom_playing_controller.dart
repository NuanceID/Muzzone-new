import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/logic/blocs/audio/audio_event.dart';
import 'package:muzzone/logic/blocs/audio/audio_state.dart';

import '../../logic/blocs/audio/audio_bloc.dart';

class BottomPlayingController extends StatelessWidget {
  const BottomPlayingController({
    Key? key,
    required this.onPlay,
    required this.isPlaying,
    required this.isPlaylist,
    required this.addToFavourite,
  }) : super(key: key);

  final bool isPlaying;
  final Function() onPlay;
  final Function() addToFavourite;
  final bool isPlaylist;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 50,
          fit: FlexFit.tight,
          child: BlocBuilder<AudioBloc, AudioState>(
            builder: (context, state) {
              return IconButton(
                onPressed: addToFavourite,
                icon: SvgPicture.asset('${iconsPath}like.svg'
                 /* state.isFavourite
                      ? '${iconsPath}like_full.svg'
                      : '${iconsPath}like.svg'*/,
                  color: Theme.of(context).cardColor /*state.isFavourite
                      ? AppColors.primaryColor
                      : Theme.of(context).cardColor*/,
                  fit: BoxFit.contain,
                  width: availableHeight/25,
                  height: availableHeight/25,
                ),
              );
            },
          ),
        ),
        const Flexible(
          fit: FlexFit.tight,
          child: SizedBox.shrink(),
        ),
        Flexible(
          flex: 50,
          fit: FlexFit.tight,
          child: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              '${iconsPath}like_add.svg',
              color: Theme.of(context).cardColor,
              fit: BoxFit.contain,
              width: availableHeight/35,
              height: availableHeight/35,
            ),
          ),
        ),
        const Flexible(
          fit: FlexFit.tight,
          child: SizedBox.shrink(),
        ),
        Flexible(
          flex: 50,
          fit: FlexFit.tight,
          child: IconButton(
            onPressed: () {
              BlocProvider.of<AudioBloc>(context).add(PlayOrPause());
            },
            icon: SvgPicture.asset(
              isPlaying ? '${iconsPath}pause.svg' : '${iconsPath}play.svg',
              color: Theme.of(context).cardColor,
              fit: BoxFit.contain,
              width: availableHeight/35,
              height: availableHeight/35,
            ),
          ),
        ),
      ],
    );
  }
}
