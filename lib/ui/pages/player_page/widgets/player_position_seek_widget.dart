import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzone/config/config.dart';

import '../../../../logic/functions/duration_to_string.dart';

class PlayerPositionSeekWidget extends StatefulWidget {
  final Duration currentPosition;
  final Duration duration;
  final Function(Duration) seekTo;

  const PlayerPositionSeekWidget({
    Key? key,
    required this.currentPosition,
    required this.duration,
    required this.seekTo,
  }) : super(key: key);

  @override
  State<PlayerPositionSeekWidget> createState() =>
      _PlayerPositionSeekWidgetState();
}

class _PlayerPositionSeekWidgetState extends State<PlayerPositionSeekWidget> {
  late Duration _visibleValue;
  bool listenOnlyUserInteraction = false;

  double get percent => widget.duration.inMilliseconds == 0
      ? 0
      : _visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  @override
  void initState() {
    super.initState();
    _visibleValue = widget.currentPosition;
  }

  @override
  void didUpdateWidget(PlayerPositionSeekWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInteraction) {
      _visibleValue = widget.currentPosition;
    }
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: availableHeight / 9,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
              Flexible(
                flex: 12,
                fit: FlexFit.tight,
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: availableHeight / 196,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 8.r,
                    ),
                  ),
                  child: Slider(
                    min: 0,
                    inactiveColor: AppColors.greyColor.withOpacity(0.5),
                    activeColor: AppColors.primaryColor,
                    max: widget.duration.inMilliseconds.toDouble(),
                    value: percent * widget.duration.inMilliseconds.toDouble(),
                    onChangeEnd: (newValue) async {
                      setState(() {
                        listenOnlyUserInteraction = false;
                        widget.seekTo(_visibleValue);
                      });
                    },
                    onChangeStart: (_) async {
                      setState(() {
                        listenOnlyUserInteraction = true;
                      });
                    },
                    onChanged: (newValue) async {
                      setState(() {
                        final to = Duration(milliseconds: newValue.floor());
                        _visibleValue = to;
                      });
                    },
                  ),
                ),
              ),
              const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
            ],
          ),
          SizedBox(
            height: availableHeight / 30,
            child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  children: [
                    const Flexible(
                        fit: FlexFit.tight, child: SizedBox.shrink()),
                    Flexible(
                        flex: 8,
                        fit: FlexFit.tight,
                        child: Text(
                          durationToString(widget.currentPosition),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: AppColors.primaryColor),
                          textAlign: TextAlign.center,
                        )),
                    const Flexible(
                        flex: 12, fit: FlexFit.tight, child: SizedBox.shrink()),
                    Flexible(
                        flex: 8,
                        fit: FlexFit.tight,
                        child: Text(
                          durationToString(widget.duration),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: AppColors.primaryColor),
                          textAlign: TextAlign.center,
                        )),
                    const Flexible(
                        fit: FlexFit.tight, child: SizedBox.shrink()),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
