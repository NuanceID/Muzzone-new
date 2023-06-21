import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/config/config.dart';
import 'package:sizer/sizer.dart';

import '../../../../logic/functions/duration_to_string.dart';
import '../bloc/audio_bloc.dart';

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

  final audioBloc = GetIt.I.get<AudioBloc>();

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
      height: 10.h,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: SliderTheme(
                  data: const SliderThemeData(
                    trackHeight: 4,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Slider(
                      min: 0,
                      inactiveColor: AppColors.greyColor.withOpacity(0.5),
                      activeColor: AppColors.primaryColor,
                      max: widget.duration.inMilliseconds.toDouble(),
                      value:
                          percent * widget.duration.inMilliseconds.toDouble(),
                      onChangeEnd: (newValue) async {
                        // audioBloc.add(AllowDrag());
                        setState(() {
                          listenOnlyUserInteraction = false;
                          widget.seekTo(_visibleValue);
                        });
                      },
                      onChangeStart: (_) async {
                        // audioBloc.add(BanDrag());
                        setState(() {
                          listenOnlyUserInteraction = true;
                        });
                      },
                      onChanged: (newValue) async {
                        // audioBloc.add(BanDrag());
                        setState(() {
                          final to = Duration(milliseconds: newValue.floor());
                          _visibleValue = to;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.5.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(durationToString(widget.currentPosition),
                      style: TextStyle(
                          color: AppColors.primaryColor, fontSize: 2.h)),
                  Text(
                    durationToString(widget.duration),
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: AppColors.primaryColor,
                        fontSize: 2.h),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
