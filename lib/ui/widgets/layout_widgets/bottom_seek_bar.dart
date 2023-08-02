import 'package:flutter/material.dart';
import 'package:muzzone/config/style/style.dart';
import 'package:muzzone/ui/widgets/common_widgets/custom_track_shape.dart';

class BottomSeekBar extends StatefulWidget {
  const BottomSeekBar({
    super.key,
    required this.duration,
    required this.position,
    this.bufferedPosition = Duration.zero,
    this.onChanged,
    this.onChangeEnd,
  });

  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  @override
  State<BottomSeekBar> createState() => _BottomSeekBarState();
}

class _BottomSeekBarState extends State<BottomSeekBar> {
  double get percent => widget.duration.inMilliseconds == 0
      ? 0.0
      : widget.position.inMilliseconds / widget.duration.inMilliseconds;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        overlayShape: SliderComponentShape.noOverlay,
        trackShape: CustomTrackShape(),
        trackHeight: 0.5,
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: 0.5,
        ),
      ),
      child: Slider(
        min: 0,
        inactiveColor: AppColors.greyColor.withOpacity(0.5),
        activeColor: AppColors.primaryColor,
        max: (widget.duration == Duration.zero ||
                widget.position == Duration.zero ||
                widget.position.inMilliseconds > widget.duration.inMilliseconds)
            ? 0.0
            : widget.duration.inMilliseconds.toDouble(),
        value: (widget.duration == Duration.zero ||
                widget.position == Duration.zero ||
                widget.position.inMilliseconds > widget.duration.inMilliseconds)
            ? 0.0
            : percent * widget.duration.inMilliseconds.toDouble(),
        onChanged: (double value) {},
      ),
    );
  }
}
