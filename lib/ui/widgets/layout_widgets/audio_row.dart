import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzone/config/constants/constants.dart';
import 'package:muzzone/ui/widgets/buttons/three_dots_button.dart';

import '../../../config/style/style.dart';
import '../common_widgets/loading_image.dart';

class AudioRow extends StatelessWidget {
  const AudioRow({
    Key? key,
    required this.audio,
    required this.onPress,
    this.paddingLeft,
  }) : super(key: key);

  final MediaItem audio;
  final Function() onPress;
  final double? paddingLeft;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: AudioListTile(
        audio: audio,
      ),
    );
  }
}

class AudioListTile extends StatelessWidget {
  const AudioListTile({Key? key, required this.audio}) : super(key: key);

  final MediaItem audio;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: availableHeight / 12 + availableHeight / 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              flex: 6,
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(),
                  ),
                  Flexible(
                    flex: 14,
                    fit: FlexFit.tight,
                    child: Card(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      child: Row(
                        children: [
                          Flexible(
                              flex: 8,
                              child: _AudioRowImage(
                                audio: audio,
                              )),
                          const Flexible(
                            fit: FlexFit.tight,
                            child: SizedBox.shrink(),
                          ),
                          Flexible(
                            flex: 32,
                            fit: FlexFit.tight,
                            child: _AudioRowText(
                              audio: audio,
                            ),
                          ),
                          const Flexible(
                            fit: FlexFit.tight,
                            child: SizedBox.shrink(),
                          ),
                          Flexible(
                              flex: 4,
                              fit: FlexFit.tight,
                              child: ThreeDotsButton(
                                fromPage: 'audio_row',
                                audio: audio,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Flexible(
              child: SizedBox(
            height: availableHeight / 80,
          )),
        ],
      ),
    );
  }
}

class _AudioRowImage extends StatelessWidget {
  const _AudioRowImage({Key? key, required this.audio}) : super(key: key);

  final MediaItem audio;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: availableHeight / 14,
      width: availableHeight / 14,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
            imageUrl: audio.artUri.toString() ?? '',
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, loadingProgress) {
              return const LoadingImage();
            }),
      ),
    );
  }
}

class _AudioRowText extends StatelessWidget {
  const _AudioRowText({Key? key, required this.audio}) : super(key: key);

  final MediaItem audio;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            audio.title,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: AppColors.primaryColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.start,
          ),
        ),
        Flexible(
          child: SizedBox(
            height: availableHeight / 70,
          ),
        ),
        Flexible(
          child: Text(
            audio.artist ?? '',
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
                color: AppColors.greyColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
