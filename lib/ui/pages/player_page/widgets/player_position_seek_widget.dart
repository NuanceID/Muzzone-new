import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/logic/audio_handler/position_data.dart';
import 'package:muzzone/logic/audio_handler/position_data_stream.dart';
import 'package:muzzone/logic/functions/duration_to_string.dart';
import 'package:muzzone/main.dart';

class PlayerPositionSeekWidget extends StatefulWidget {
  const PlayerPositionSeekWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PlayerPositionSeekWidget> createState() =>
      _PlayerPositionSeekWidgetState();
}

class _PlayerPositionSeekWidgetState extends State<PlayerPositionSeekWidget> {
  var percent = 0.0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PositionData>(
        stream: positionDataStream,
        builder: (context, snapshot) {
          final positionData = snapshot.data ??
              PositionData(Duration.zero, Duration.zero, Duration.zero);

          percent = positionData.position.inMilliseconds /
              positionData.duration.inMilliseconds;

          return Column(children: [
            Flexible(
                flex: 10,
                fit: FlexFit.tight,
                child: SliderTheme(
                  data: const SliderThemeData(
                    trackHeight: 4,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                  ),
                  child: Slider(
                    min: 0,
                    inactiveColor: AppColors.greyColor.withOpacity(0.5),
                    activeColor: AppColors.primaryColor,
                    max: (positionData.duration == Duration.zero ||
                            positionData.position.inMilliseconds >
                                positionData.duration.inMilliseconds)
                        ? 0.0
                        : positionData.duration.inMilliseconds.toDouble(),
                    value: (positionData.duration == Duration.zero ||
                            positionData.position.inMilliseconds >
                                positionData.duration.inMilliseconds)
                        ? 0.0
                        : percent *
                            positionData.duration.inMilliseconds.toDouble(),
                    onChanged: (double value) async {
                      await audioHandler
                          .seek(Duration(milliseconds: value.floor()));
                    },
                  ),
                )),
            const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
            Flexible(
                flex: 20,
                fit: FlexFit.tight,
                child: Row(
                  children: [
                    const Flexible(
                        flex: 4, fit: FlexFit.tight, child: SizedBox.shrink()),
                    Flexible(
                        flex: 30,
                        fit: FlexFit.tight,
                        child: Text(
                          durationToString(positionData.position),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: AppColors.primaryColor),
                          textAlign: TextAlign.start,
                        )),
                    const Flexible(
                        fit: FlexFit.tight, child: SizedBox.shrink()),
                    Flexible(
                        flex: 30,
                        fit: FlexFit.tight,
                        child: Text(
                          durationToString(positionData.duration),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: AppColors.primaryColor),
                          textAlign: TextAlign.end,
                        )),
                    const Flexible(
                        flex: 4, fit: FlexFit.tight, child: SizedBox.shrink()),
                  ],
                ))
          ]);
        });
  }
}
