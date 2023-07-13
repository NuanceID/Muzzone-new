import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/style/style.dart';
import '../../../widgets/common_widgets/custom_track_shape.dart';

class PlayerBottomPositionSeek extends StatefulWidget {
  const PlayerBottomPositionSeek({
    Key? key,
    required this.currentPosition,
    required this.duration,
    required this.seekTo,
  }) : super(key: key);

  final Duration currentPosition;
  final Duration duration;
  final Function(Duration) seekTo;

  @override
  State<PlayerBottomPositionSeek> createState() =>
      _PlayerBottomPositionSeekState();
}

class _PlayerBottomPositionSeekState extends State<PlayerBottomPositionSeek> {
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
  void didUpdateWidget(PlayerBottomPositionSeek oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInteraction) {
      _visibleValue = widget.currentPosition;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Material(
        color: Colors.transparent,
        child: SliderTheme(
      data: SliderThemeData(
        overlayShape: SliderComponentShape.noOverlay,
        trackShape: CustomTrackShape(),
        trackHeight: 0.5.h,
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: 0,
        ),
      ),
      child: Slider(
        min: 0,
        inactiveColor: AppColors.greyColor.withOpacity(0.5),
        activeColor: AppColors.primaryColor,
        max: widget.duration.inMilliseconds.toDouble(),
        value: percent * widget.duration.inMilliseconds.toDouble(),
        onChanged: (double value) {},
      ),
    ));
  }
}
