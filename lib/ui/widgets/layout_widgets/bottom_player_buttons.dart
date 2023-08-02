import 'package:audio_service/audio_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/logic/blocs/my_playlists/my_playlists_bloc.dart';
import 'package:muzzone/logic/blocs/my_playlists/my_playlists_event.dart';
import 'package:muzzone/main.dart';
import 'package:muzzone/ui/pages/main_page/widgets/add_media_button.dart';

class BottomPlayerButtons extends StatefulWidget {
  const BottomPlayerButtons({super.key});

  @override
  State<BottomPlayerButtons> createState() => _BottomPlayerButtonsState();
}

class _BottomPlayerButtonsState extends State<BottomPlayerButtons> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController()
      ..addListener(() {
        bool contain = BlocProvider.of<MyPlayListsBloc>(context)
                .state
                .myPlayLists
                .firstWhereOrNull((e) =>
                    e.title.trim() == _textEditingController.text.trim()) !=
            null;

        if (_textEditingController.text.isNotEmpty) {
          if (contain) {
            BlocProvider.of<MyPlayListsBloc>(context).add(
                const ValidateMyPlayListName(isMyPlaylistNameValidated: false));
          } else if (!contain) {
            BlocProvider.of<MyPlayListsBloc>(context).add(
                const ValidateMyPlayListName(isMyPlaylistNameValidated: true));
          }
        } else {
          BlocProvider.of<MyPlayListsBloc>(context).add(
              const ValidateMyPlayListName(isMyPlaylistNameValidated: false));
        }
      });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
            flex: 60,
            fit: FlexFit.tight,
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                '${iconsPath}like.svg',
                /*state.isFavourite
                ? '${iconsPath}like_full.svg'
                : '${iconsPath}like.svg',*/
                color: Theme.of(context)
                    .cardColor, /*state.isFavourite
                ? AppColors.primaryColor
                : Theme.of(context).cardColor,*/
              ),
            )),
        const Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox.shrink()),
        Flexible(
            flex: 57,
            fit: FlexFit.tight,
            child: AddMediaButton(
              from: 'bottom_player_buttons',
              textEditingController: _textEditingController,
            ) /*Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                child: IconButton(
                  onPressed: () {

                  },
                  icon: SvgPicture.asset(
                    '${iconsPath}like_add.svg',
                    color: Theme.of(context).cardColor,
                  ),
                ))*/
            ),
        const Flexible(flex: 6, fit: FlexFit.tight, child: SizedBox.shrink()),
        Flexible(
            flex: 50,
            child: StreamBuilder<PlaybackState>(
              stream: audioHandler.playbackState,
              builder: (context, snapshot) {
                final playbackState = snapshot.data;
                final processingState = playbackState?.processingState;
                final playing = playbackState?.playing;

                if (processingState == AudioProcessingState.loading ||
                    processingState == AudioProcessingState.buffering) {
                  return SizedBox(
                    width: availableHeight / 20,
                    height: availableHeight / 20,
                    child: Center(
                        child: SizedBox(
                            width: availableHeight / 35,
                            height: availableHeight / 35,
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                              strokeWidth: 3.w,
                            ))),
                  );
                }

                return IconButton(
                  onPressed: () {
                    if (playing == true) {
                      audioHandler.pause();
                    } else if (playing == false) {
                      audioHandler.play();
                    }
                  },
                  icon: SvgPicture.asset(
                    playing == true
                        ? '${iconsPath}pause.svg'
                        : '${iconsPath}play.svg',
                    color: Theme.of(context).cardColor,
                    width: availableHeight / 35,
                    height: availableHeight / 35,
                  ),
                );
              },
            ))
      ],
    );
  }
}
