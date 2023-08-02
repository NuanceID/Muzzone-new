import 'package:audio_service/audio_service.dart';
import 'package:muzzone/logic/audio_handler/position_data.dart';
import 'package:muzzone/main.dart';
import 'package:rxdart/rxdart.dart';

Stream<Duration> get _bufferedPositionStream => audioHandler.playbackState
    .map((state) => state.bufferedPosition)
    .distinct();

Stream<Duration?> get _durationStream => audioHandler.duration.distinct();

Stream<PositionData> get positionDataStream =>
    Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        AudioService.position,
        _bufferedPositionStream,
        _durationStream,
            (position, bufferedPosition, duration) => PositionData(
            position, bufferedPosition, duration ?? Duration.zero));