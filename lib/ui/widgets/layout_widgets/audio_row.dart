import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muzzone/ui/widgets/buttons/three_dots_button.dart';
import 'package:sizer/sizer.dart';

import '../../../config/style/style.dart';
import '../common_widgets/loading_image.dart';

class AudioRow extends StatelessWidget {
  const AudioRow({
    Key? key,
    required this.audio,
    required this.onPress,
    required this.height,
    this.paddingLeft,
  }) : super(key: key);

  final Audio audio;
  final Function() onPress;
  final double height;
  final double? paddingLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: paddingLeft ?? 7.w, right: 7.w, bottom: 2.h),
      child: GestureDetector(
        onTap: onPress,
        child: AudioListTile(
          audio: audio,
          height: height,
        ),
      ),
    );
  }
}

class AudioListTile extends StatelessWidget {
  const AudioListTile({Key? key, required this.audio, required this.height})
      : super(key: key);

  final Audio audio;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: height,
      child: Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Row(
          children: [
            Flexible(
                flex: 20,
                child: _AudioRowImage(
                  audio: audio,
                  height: height,
                )),
            Flexible(
              flex: 100,
              fit: FlexFit.tight,
              child: _AudioRowText(
                audio: audio,
              ),
            ),
            const Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: SizedBox.shrink(),
            ),
            Flexible(
                flex: 10,
                fit: FlexFit.tight,
                child: ThreeDotsButton(
                  fromPage: 'main_page',
                  audio: audio,
                ))
          ],
        ),
      ),
    );
  }
}

class _AudioRowImage extends StatelessWidget {
  const _AudioRowImage({Key? key, required this.audio, required this.height})
      : super(key: key);

  final Audio audio;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(imageUrl: audio.metas.image?.path ?? '', fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, loadingProgress) {
              return const LoadingImage();
            }),/*Image.network(audio.metas.image?.path ?? '', fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const LoadingImage();
        }),*/
      ),
    );
  }
}

class _AudioRowText extends StatelessWidget {
  const _AudioRowText({Key? key, required this.audio}) : super(key: key);

  final Audio audio;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            audio.metas.title!,
            style: TextStyle(
              fontSize: audio.metas.title!.length > 22 ? 10.sp : 12.sp,
            ),
            maxLines: 1,
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            audio.metas.artist!,
            style: TextStyle(color: AppColors.greyColor, fontSize: 10.sp),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
