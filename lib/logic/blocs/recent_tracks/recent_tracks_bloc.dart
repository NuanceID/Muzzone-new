import 'package:dartx/dartx.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzzone/data/models/track.dart';
import 'package:muzzone/logic/blocs/recent_tracks/recent_tracks_event.dart';
import 'package:muzzone/logic/blocs/recent_tracks/recent_tracks_state.dart';

class RecentTracksBloc extends Bloc<RecentTracksEvent, RecentTracksState> {
  RecentTracksBloc() : super(const RecentTracksState()) {
    on<GetRecentTracks>(_getRecentTracks);
    on<PutTrack>(_putTrack);
    on<SetCurrentTrack>(_setCurrentTrack);
  }

  _getRecentTracks(
      GetRecentTracks event, Emitter<RecentTracksState> emitter) async {
    emitter(state.copyWith(recentTracksStatus: RecentTracksStatus.loading));

    var box = Hive.box<Track>('recentTracks');

    return emitter(state.copyWith(
        recentTracksStatus: RecentTracksStatus.success,
        recentTracks: box.values.reversed.toList()));
  }

  _putTrack(PutTrack event, Emitter<RecentTracksState> emitter) async {
    var box = Hive.box<Track>('recentTracks');

    if (box.length < 100) {
      box.put(DateTime.now().toUtc().toString(), event.track);
    } else {
      box.deleteAt(100);
      box.put(DateTime.now().toUtc().toString(), event.track);
    }

    return emitter(state.copyWith(
        recentTracksStatus: RecentTracksStatus.success,
        recentTracks: box.values.reversed.toList()));
  }

  _setCurrentTrack(
      SetCurrentTrack event, Emitter<RecentTracksState> emitter) async {
    return emitter(state.copyWith(currentTrack: event.track));
  }
}
