import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/ui/widgets/buttons/three_dots_button.dart';

class PlaylistRow extends StatelessWidget {
  const PlaylistRow({
    Key? key,
    required this.onPress,
    required this.playlist,
    this.paddingLeft,
  }) : super(key: key);

  final MyPlaylist playlist;
  final Function() onPress;
  final double? paddingLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            left: availableHeight / 50, right: availableHeight / 50),
        child: Material(
            clipBehavior: Clip.hardEdge,
            color: Colors.transparent,
            child: InkWell(
                borderRadius: BorderRadius.circular(5.r),
                onTap: onPress,
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5.r)),
                    margin: EdgeInsets.only(bottom: availableHeight / 100),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                            child: SizedBox(
                          height: availableHeight / 100,
                        )),
                        Flexible(
                            child: Row(
                          children: [
                            const Flexible(
                                flex: 3,
                                fit: FlexFit.tight,
                                child: SizedBox.shrink()),
                            Flexible(
                              flex: 30,
                              fit: FlexFit.tight,
                              child: Text(
                                playlist.title,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Flexible(
                                fit: FlexFit.tight, child: SizedBox.shrink()),
                            Flexible(
                              flex: 4,
                              fit: FlexFit.tight,
                              child: ThreeDotsButton(
                                  playlist: playlist, fromPage: 'playlist_row'),
                            ),
                            const Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: SizedBox.shrink()),
                          ],
                        )),
                        Flexible(
                            child: SizedBox(
                          height: availableHeight / 100,
                        )),
                      ],
                    )))));
  }
}
