import 'package:flutter/material.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/logic/audio_handler/position_data.dart';
import 'package:muzzone/logic/audio_handler/position_data_stream.dart';
import 'package:muzzone/ui/widgets/layout_widgets/bottom_seek_bar.dart';

class BottomPlayerPositionSeekWidget extends StatefulWidget {
  const BottomPlayerPositionSeekWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomPlayerPositionSeekWidget> createState() =>
      _BottomPlayerPositionSeekWidgetState();
}

class _BottomPlayerPositionSeekWidgetState
    extends State<BottomPlayerPositionSeekWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PositionData>(
      stream: positionDataStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data ??
            PositionData(Duration.zero, Duration.zero, Duration.zero);

        return SizedBox(
          height: availableHeight / 9,
          width: double.infinity,
          child: BottomSeekBar(
            duration: positionData.duration,
            position: positionData.position,
          ),
        );
      },
    );
  }
}
