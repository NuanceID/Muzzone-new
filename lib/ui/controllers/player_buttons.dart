import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/logic/audio/queue_state.dart';
import 'package:muzzone/main.dart';

class PlayerButtons extends StatefulWidget {

  const PlayerButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<PlayerButtons> createState() => _PlayerButtonsState();
}

class _PlayerButtonsState extends State<PlayerButtons> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: StreamBuilder<QueueState>(
            stream: audioHandler.queueState,
            builder: (context, snapshot) {
              final queueState = snapshot.data ?? QueueState.empty;
              return IconButton(
                onPressed: (){
                  audioHandler.setRepeatMode(repeatMode);
                },
                icon: SvgPicture.asset(
                  '${iconsPath}previous.svg',
                  color: queueState.hasPrevious ? AppColors.primaryColor : AppColors.greyColor,
                ),
              );
            },
          )
          
          IconButton(
            onPressed: () {
              
            },
            icon: SvgPicture.asset(
              '${iconsPath}repeat.svg',
              color: isLooped ? AppColors.primaryColor : AppColors.greyColor,
            ),
          ),
        ),
        const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: StreamBuilder<QueueState>(
            stream: audioHandler.queueState,
            builder: (context, snapshot) {
              final queueState = snapshot.data ?? QueueState.empty;
              return IconButton(
                onPressed: queueState.hasPrevious ? audioHandler.skipToPrevious : null/*() {
                  BlocProvider.of<AudioBloc>(context)
                      .state
                      .justAudioPlayer
                      .previous();
                }*/,
                icon: SvgPicture.asset(
                  '${iconsPath}previous.svg',
                  color: queueState.hasPrevious ? AppColors.primaryColor : AppColors.greyColor,
                ),
              );
            },
          ),
        ),

        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: StreamBuilder<PlaybackState>(
            stream: audioHandler.playbackState,
            builder: (context, snapshot) {
              final playbackState = snapshot.data;
              final processingState = playbackState?.processingState;
              final playing = playbackState?.playing;

              if (processingState == AudioProcessingState.loading ||
                  processingState == AudioProcessingState.buffering) {
                return SizedBox(
                  width: availableHeight / 13,
                  height: availableHeight / 13,
                  child: const CircularProgressIndicator(color: AppColors.primaryColor,),
                );
              }

              return IconButton(
                iconSize: availableHeight / 13,
                onPressed: () {
                  BlocProvider.of<AudioBloc>(context)
                      .state
                      .justAudioPlayer
                      .playOrPause();
                },
                icon: SvgPicture.asset(
                  playing != true
                      ? '${iconsPath}pause_outlines.svg'
                      : '${iconsPath}play_outlines.svg',
                  fit: BoxFit.fitHeight,
                ),
              );
            },
          ),
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: StreamBuilder<QueueState>(
            stream: audioHandler.queueState,
            builder: (context, snapshot) {
              final queueState = snapshot.data ?? QueueState.empty;
              return IconButton(
                onPressed: queueState.hasNext ? audioHandler.skipToNext : null/*() {
                  BlocProvider.of<AudioBloc>(context)
                      .state
                      .justAudioPlayer
                      .next();
                }*/,
                icon: SvgPicture.asset(
                  '${iconsPath}next.svg',
                  color: queueState.hasNext ? AppColors.primaryColor : AppColors.greyColor,
                ),
              );
            },
          ),
        ),
        const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: IconButton(
            onPressed: () {
              BlocProvider.of<AudioBloc>(context)
                  .state
                  .justAudioPlayer
                  .toggleShuffle();
              setState(() {
                isShuffled = BlocProvider.of<AudioBloc>(context)
                    .state
                    .justAudioPlayer
                    .isShuffling
                    .value;
              });
            },
            icon: SvgPicture.asset(
              '${iconsPath}mix.svg',
              color: isShuffled ? AppColors.primaryColor : AppColors.greyColor,
            ),
          ),
        ),
      ],
    );
  }
}
