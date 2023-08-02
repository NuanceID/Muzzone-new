import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/logic/audio_handler/queue_state.dart';
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
                  onPressed: () {
                    if(queueState.repeatMode == AudioServiceRepeatMode.all){
                      audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
                    }else if (queueState.repeatMode == AudioServiceRepeatMode.none) {
                      audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
                    }
                  },
                  icon: SvgPicture.asset(
                    '${iconsPath}repeat.svg',
                    color: queueState.repeatMode == AudioServiceRepeatMode.all
                        ? AppColors.primaryColor
                        : AppColors.greyColor,
                  ),
                );
              },
            )),
        const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: StreamBuilder<QueueState>(
            stream: audioHandler.queueState,
            builder: (context, snapshot) {
              final queueState = snapshot.data ?? QueueState.empty;
              return IconButton(
                onPressed:
                    queueState.hasPrevious ? audioHandler.skipToPrevious : null,
                icon: SvgPicture.asset(
                  '${iconsPath}previous.svg',
                  color: queueState.hasPrevious
                      ? AppColors.primaryColor
                      : AppColors.greyColor,
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
                  width: availableHeight / 16,
                  height: availableHeight / 16,
                  child: Center(
                      child: SizedBox(
                          width: availableHeight / 16,
                          height: availableHeight / 16,
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                            strokeWidth: 4.w,
                          ))),
                );
              }

              return IconButton(
                iconSize: availableHeight / 13,
                onPressed: () {
                  if(playing == true) {
                    audioHandler.pause();
                  }else if(playing == false) {
                    audioHandler.play();
                  }
                },
                icon: SvgPicture.asset(
                  playing == true
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
                onPressed: queueState.hasNext
                    ? audioHandler.skipToNext
                    : null,
                icon: SvgPicture.asset(
                  '${iconsPath}next.svg',
                  color: queueState.hasNext
                      ? AppColors.primaryColor
                      : AppColors.greyColor,
                ),
              );
            },
          ),
        ),
        const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: StreamBuilder<bool>(
            stream: audioHandler.playbackState
                .map(
                    (state) => state.shuffleMode == AudioServiceShuffleMode.all)
                .distinct(),
            builder: (context, snapshot) {
              final shuffleModeEnabled = snapshot.data ?? false;
              return IconButton(
                icon: SvgPicture.asset(
                  '${iconsPath}mix.svg',
                  color: shuffleModeEnabled
                      ? AppColors.primaryColor
                      : AppColors.greyColor,
                ),
                onPressed: () async {
                  final enable = !shuffleModeEnabled;
                  await audioHandler.setShuffleMode(enable
                      ? AudioServiceShuffleMode.all
                      : AudioServiceShuffleMode.none);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
