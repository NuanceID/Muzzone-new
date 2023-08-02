import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel/sliding_up_panel_bloc.dart';
import 'package:muzzone/logic/blocs/sliding_up_panel/sliding_up_panel_event.dart';
import 'package:muzzone/main.dart';
import 'package:muzzone/ui/widgets/layout_widgets/bottom_player_buttons.dart';
import 'package:muzzone/ui/widgets/layout_widgets/bottom_player_position_seek_widget.dart';

import '../../../config/config.dart';
import '../widgets.dart';

class BottomPlayerWidget extends StatelessWidget {
  const BottomPlayerWidget({Key? key, required this.onPress}) : super(key: key);

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem?>(
        stream: audioHandler.mediaItem,
        builder: (context, snapshot) {
          final mediaItem = snapshot.data;
          if (mediaItem == null) return const SizedBox.shrink();

          return GestureDetector(
            onTap: () {
              BlocProvider.of<SlidingUpPanelBloc>(context)
                  .add(OpenSlidingPanel());
            },
            child: Container(
              height: availableHeight / 8,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.r),
                    topLeft: Radius.circular(20.r)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                      flex: 10,
                      fit: FlexFit.tight,
                      child: Row(
                        children: [
                          const Flexible(
                              fit: FlexFit.tight, child: SizedBox.shrink()),
                          Flexible(
                            flex: 30,
                            fit: FlexFit.tight,
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 45,
                                  fit: FlexFit.tight,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(3.r),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          mediaItem.artUri.toString() ?? '',
                                      width: availableHeight / 17,
                                      height: availableHeight / 17,
                                      progressIndicatorBuilder:
                                          (context, url, l) =>
                                              const LoadingImage(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: SizedBox.shrink()),
                                Flexible(
                                  flex: 220,
                                  fit: FlexFit.tight,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Flexible(
                                          fit: FlexFit.tight,
                                          child: SizedBox.shrink()),
                                      Flexible(
                                        flex: 10,
                                        child: Text(
                                          mediaItem.title ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13.sp,
                                              color: Colors.black),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      const Flexible(
                                          fit: FlexFit.tight,
                                          child: SizedBox.shrink()),
                                      Flexible(
                                          flex: 10,
                                          child: Text(
                                            mediaItem.artist ?? '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp,
                                                color: AppColors.greyColor),
                                            textAlign: TextAlign.start,
                                          )),
                                      const Flexible(
                                          fit: FlexFit.tight,
                                          child: SizedBox.shrink()),
                                    ],
                                  ),
                                ),
                                const Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: SizedBox.shrink()),
                                const Flexible(
                                  flex: 120,
                                  fit: FlexFit.tight,
                                  child: BottomPlayerButtons(),
                                ),
                              ],
                            ),
                          ),
                          const Flexible(
                              fit: FlexFit.tight, child: SizedBox.shrink()),
                        ],
                      )),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Row(
                      children: const [
                        Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
                        Flexible(
                            flex: 30,
                            fit: FlexFit.tight,
                            child: BottomPlayerPositionSeekWidget()),
                        Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
