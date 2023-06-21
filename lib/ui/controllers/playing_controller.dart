// ignore: file_names
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muzzone/config/config.dart';
import 'package:sizer/sizer.dart';

import 'controllers.dart';

class PlayingController extends StatefulWidget {
  final bool isPlaying;
  final LoopMode? loopMode;
  final bool isPlaylist;
  final MainController con;
  final Function()? onPrevious;
  final Function() onPlay;
  final Function()? onNext;
  final Function()? toggleLoop;
  final Function()? onStop;

  const PlayingController({
    Key? key,
    required this.isPlaying,
    this.loopMode,
    this.isPlaylist = false,
    required this.con,
    this.onPrevious,
    required this.onPlay,
    this.onNext,
    this.toggleLoop,
    this.onStop,
  }) : super(key: key);

  @override
  State<PlayingController> createState() => _PlayingControllerState();
}

class _PlayingControllerState extends State<PlayingController> {
  bool isSuffled = false;
  @override
  void initState() {
    setState(() {
      isSuffled = widget.con.player.shuffle;
    });
    super.initState();
  }

  SvgPicture loopIcon(BuildContext context) {
    if (widget.loopMode == LoopMode.none) {
      return SvgPicture.asset(
        '${iconsPath}repeat.svg',
        color: AppColors.greyColor,
      );
    } else if (widget.loopMode == LoopMode.playlist) {
      return SvgPicture.asset(
        '${iconsPath}repeat.svg',
        color: AppColors.greyColor,
      );
    } else {
      return SvgPicture.asset(
        '${iconsPath}repeat.svg',
        color: AppColors.primaryColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          padding: EdgeInsets.only(bottom: 1.h),
          onPressed: () {
            if (widget.toggleLoop != null) widget.toggleLoop!();
          },
          icon: loopIcon(context),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: widget.isPlaylist ? widget.onPrevious : null,
              icon: SvgPicture.asset(
                '${iconsPath}previous.svg',
                color: AppColors.primaryColor,
              ),
            ),
            IconButton(
              iconSize: 50.sp,
              onPressed: widget.onPlay,
              icon: SvgPicture.asset(
                width: 150.sp,
                height: 150.sp,
                widget.isPlaying
                    ? '${iconsPath}pause_outlines.svg'
                    : '${iconsPath}play_outlines.svg',
                fit: BoxFit.fill,
              ),
            ),
            IconButton(
              onPressed: widget.isPlaylist ? widget.onNext : null,
              icon: SvgPicture.asset(
                '${iconsPath}next.svg',
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        IconButton(
          padding: EdgeInsets.only(bottom: 1.h),
          onPressed: () {
            setState(() {
              isSuffled = !isSuffled;
            });
            widget.con.player.toggleShuffle();
          },
          icon: SvgPicture.asset(
            '${iconsPath}mix.svg',
            color: isSuffled ? AppColors.primaryColor : AppColors.greyColor,
          ),
        ),
      ],
    );
  }
}
