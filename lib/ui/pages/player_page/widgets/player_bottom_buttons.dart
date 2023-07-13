import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/logic/blocs/audio/audio_state.dart';

import '../../../../logic/blocs/audio/audio_bloc.dart';

class PlayerBottomButtons extends StatelessWidget {
  const PlayerBottomButtons({
    Key? key,
    required this.like,
    required this.share,
    required this.likeAdd,
    required this.search,
  }) : super(key: key);

  final Function() like;
  final Function() share;
  final Function() likeAdd;
  final Function() search;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.r),
            topLeft: Radius.circular(15.r),
          ),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0),
                spreadRadius: 0,
                blurRadius: 2.r,
                color: Colors.grey.shade400)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
          Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: BlocBuilder<AudioBloc, AudioState>(
              builder: (context, state) {
                return PlayerBottomButton(
                  icon: /*state.isFavourite ? 'like_full' : */'like',
                  color: /*state.isFavourite ? AppColors.primaryColor : */null,
                  onPress: like,
                );
              },
            ),
          ),
          const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
          Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: PlayerBottomButton(
              icon: 'share',
              onPress: share,
            ),
          ),
          const Flexible(flex: 30, fit: FlexFit.tight, child: SizedBox.shrink()),
        ],
      ),
    );
  }
}

class PlayerBottomButton extends StatelessWidget {
  const PlayerBottomButton({
    required this.icon,
    required this.onPress,
    this.color,
    super.key,
  });

  final String icon;
  final VoidCallback onPress;
  final Color? color;

  @override
  Widget build(BuildContext context) {

    return Material(
      shape: const CircleBorder(),
      color: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onPress,
        child: Ink(
            padding: EdgeInsets.all(availableHeight / 60),
            child: SvgPicture.asset(
              '$iconsPath$icon.svg',
              width: availableHeight / 35,
              height: availableHeight / 35,
              fit: BoxFit.contain,
              color: color ?? Theme.of(context).cardColor,
            )),
      ),
    );
  }
}
