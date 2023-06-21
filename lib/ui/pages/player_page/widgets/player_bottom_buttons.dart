import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muzzone/config/config.dart';
import 'package:sizer/sizer.dart';

import '../bloc/audio_bloc.dart';

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
    return SizedBox(
      height: Space.bottomBarHeight,
      width: 100.w,
      // decoration: BoxDecoration(
      //   color: Theme.of(context).scaffoldBackgroundColor,
      //   borderRadius: const BorderRadius.only(
      //     topLeft: Radius.circular(
      //       20,
      //     ),
      //     topRight: Radius.circular(
      //       20,
      //     ),
      //   ),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.5),
      //       spreadRadius: 0,
      //       blurRadius: 3,
      //       offset: const Offset(0, 0), // changes position of shadow
      //     ),
      //   ],
      // ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<AudioBloc, AudioState>(
              builder: (context, state) {
                return PlayerBottomButton(
                  index: 0,
                  icon: state.isFavourite ? 'like_full' : 'like',
                  color: state.isFavourite ? AppColors.primaryColor : null,
                  onPress: like,
                );
              },
            ),
            PlayerBottomButton(
              index: 1,
              icon: 'share',
              onPress: share,
            ),
            // PlayerBottomButton(
            //   icon: 'like_add',
            //   onPress: likeAdd,
            // ),
            // PlayerBottomButton(
            //   icon: 'search',
            //   onPress: search,
            // ),
          ],
        ),
      ),
    );
  }
}

class PlayerBottomButton extends StatelessWidget {
  const PlayerBottomButton({
    required this.icon,
    required this.onPress,
    this.color,
    required this.index,
    super.key,
  });

  final String icon;
  final VoidCallback onPress;
  final Color? color;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10.h,
      height: 7.h,
      color: Colors.red.withOpacity(0),
      child: InkWell(
        onTap: onPress,
        child: Container(
          width: 3.5.h,
          height: 3.5.h,
          margin: EdgeInsets.only(
              right: index == 1 ? 2.w : 0, left: index == 0 ? 2.w : 0),
          child: Align(
            alignment:
                index == 0 ? Alignment.centerLeft : Alignment.centerRight,
            child: SvgPicture.asset(
              '$iconsPath$icon.svg',
              width: 3.5.h,
              height: 3.5.h,
              fit: BoxFit.none,
              color: color ?? Theme.of(context).cardColor,
            ),
          ),
        ),
      ),
    );
  }
}
