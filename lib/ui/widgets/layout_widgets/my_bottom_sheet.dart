/*
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/logic/blocs/audio/audio_state.dart';
import 'package:muzzone/logic/blocs/favourite_audios/favourite_audios_bloc.dart';
import 'package:muzzone/logic/blocs/favourite_audios/favourite_audios_event.dart';
import 'package:muzzone/logic/blocs/favourite_audios/favourite_audios_state.dart';
import 'package:muzzone/logic/functions/share_function.dart';
import 'package:muzzone/logic/blocs/favorite_audios/favourite_audios_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../generated/locale_keys.g.dart';
import '../../pages/album/view/album_page.dart';
import '../../../logic/blocs/audio/audio_bloc.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({Key? key, required this.fromPage, required this.item})
      : super(key: key);

  final dynamic item;
  final String fromPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        height: 100.h,
        width: 100.w,
        color: Colors.white.withOpacity(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).dialogBackgroundColor,
                  borderRadius: BorderRadius.circular(15)),
              width: 90.w,
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HeaderTitleBottomSheet(item: item),
                    SizedBox(height: 2.h),
                    const DividerBottomSheet(),
                    SizedBox(height: 1.h),
                    ColumnBottomSheet(item: item, fromPage: fromPage),
                  ],
                ),
              ),
            ),
            SizedBox(height: 1.h),
            const CancelButtonBottomSheet(),
            BlocBuilder<AudioBloc, AudioState>(
              builder: (context, state) {
                return SizedBox(height: 1.h + Space.bottomBarHeight * 2);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CancelButtonBottomSheet extends StatelessWidget {
  const CancelButtonBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.circular(15)),
      height: 7.h,
      width: 90.w,
      child: Center(
        child: Text(
          LocaleKeys.cancel.tr(),
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Theme.of(context).splashColor, fontSize: 14.sp),
        ),
      ),
    );
  }
}

class ColumnBottomSheet extends StatelessWidget {
  const ColumnBottomSheet({
    Key? key,
    required this.item,
    required this.fromPage,
  }) : super(key: key);

  final dynamic item;
  final String fromPage;


  @override
  Widget build(BuildContext context) {

    final favouriteAudiosBloc = context.read<FavouriteAudiosBloc>();

    return Column(
      children: [
        if (item is Audio)
          BlocBuilder<FavouriteAudiosBloc, FavouriteAudiosState>(
            builder: (context, state) {
              return ButtonBottomSheet(
                icon: state.favouriteList.contains(item) ? 'like_full' : 'like',
                text: LocaleKeys.like.tr(),
                onPress: () => favouriteAudiosBloc
                    .add(AddOrRemoveEvent(int.parse(item.metas.id))),
                color: state.favouriteList.contains(item)
                    ? AppColors.primaryColor
                    : null,
              );
            },
          ),
        if (item is Audio)
          ButtonBottomSheet(
              icon: 'plus', text: LocaleKeys.add_playlist.tr(), onPress: () {}),
        ButtonBottomSheet(
            icon: 'share',
            text: LocaleKeys.share.tr(),
            onPress: () => shareFunction(
                'Рекомендую в приложении MuZZone послушать песню "${item.metas.name}" исполнителя "${item.metas.artists}" по ссылке ${item.audio}',
                context,
                true)),
        if (item is Audio && fromPage != 'artist_page')
          ButtonBottomSheet(
              icon: 'go_artist',
              text: LocaleKeys.go_to_artist.tr(),
              onPress: () {
                Navigator.pop(context);
              }),
        if (item is Audio && fromPage != 'album_page')
          ButtonBottomSheet(
              icon: 'go_album',
              text: LocaleKeys.go_to_album.tr(),
              onPress: () {
                Navigator.pop(context);
                for (var album in con.audios) {
                  if (album.metas.album == item.metas.album) {
                    Navigator.of(context).pushNamed(AlbumPage.id,
                        arguments: AlbumPageArguments(album: con.audios));
                  }
                  return;
                }
              }),
        if (item is Audio)
          ButtonBottomSheet(
              icon: 'delete',
              text: LocaleKeys.delete_from_playlist.tr(),
              onPress: () {}),
      ],
    );
  }
}

class DividerBottomSheet extends StatelessWidget {
  const DividerBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      height: 0.3.h,
      padding: EdgeInsets.symmetric(
        horizontal: MyPadding.horizontalPadding,
      ),
      color: AppColors.greyColor.withOpacity(0.3),
    );
  }
}

class ButtonBottomSheet extends StatelessWidget {
  const ButtonBottomSheet({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPress,
    this.color,
  }) : super(key: key);

  final String icon;
  final String text;
  final VoidCallback onPress;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).dialogBackgroundColor,
      child: ListTile(
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        contentPadding: EdgeInsets.zero,
        leading: SvgPicture.asset(
          '$iconsPath$icon.svg',
          width: 3.5.h,
          height: 4.h,
          color: color ?? Theme.of(context).splashColor,
        ),
        minLeadingWidth: 0.sp,
        onTap: onPress,
        title: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).splashColor,
            fontSize: 2.2.h,
          ),
        ),
      ),
    );
  }
}

class HeaderTitleBottomSheet extends StatelessWidget {
  const HeaderTitleBottomSheet({
    Key? key,
    required this.item,
  }) : super(key: key);

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: SizedBox(
              width: 6.5.h,
              height: 6.5.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  item.metas.image.path,
                  //item.metas.cover.path,
                  fit: BoxFit.cover,
                ),
              ),
            )),
        Flexible(
            fit: FlexFit.tight,
            child: SizedBox(
              width: 5.w,
            )),
        Flexible(
            flex: 23,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.metas.title,
                  //item.metas.name,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 14.sp),
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
                Text(
                  item.metas.album,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.greyColor, fontSize: 12.sp),
                  maxLines: 1,
                  textAlign: TextAlign.start,
                )
              ],
            ))
      ],
    );
  }
}
*/
