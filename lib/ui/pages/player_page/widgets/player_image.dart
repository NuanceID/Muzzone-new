import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/common_widgets/loading_image.dart';

class PlayerImage extends StatelessWidget {
  const PlayerImage({
    Key? key,
    required this.myAudio,
  }) : super(key: key);

  final Audio myAudio;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        height: 38.h,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            myAudio.metas.image!.path,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return LoadingImage(
                size: 15.h,
              );
            },
          ),
        ),
      ),
    );
  }
}
