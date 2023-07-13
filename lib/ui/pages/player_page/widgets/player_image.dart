import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muzzone/config/style/style.dart';

class PlayerImage extends StatelessWidget {
  const PlayerImage({
    Key? key,
    required this.myAudio,
  }) : super(key: key);

  final MediaItem myAudio;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Image.network(
          myAudio.artUri?.path ?? '',
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor,)
            );
          },
          /*loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const LoadingImage();
          },*/
        ),
      ),
    );
  }
}
