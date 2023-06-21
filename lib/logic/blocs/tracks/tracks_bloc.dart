import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzzone/config/network_state/network_state.dart';
import 'package:muzzone/data/models/track.dart';
import 'package:muzzone/data/models/tracks.dart';
import 'package:muzzone/data/models/user.dart';
import 'package:muzzone/data/repositories/remote_repositories/backend_repository.dart';
import 'package:muzzone/logic/blocs/tracks/tracks_event.dart';
import 'package:muzzone/logic/blocs/tracks/tracks_state.dart';

class TracksBloc extends Bloc<TracksEvent, TracksState> {
  final BackendRepository _backendRepository;

  TracksBloc({required BackendRepository backendRepository})
      : _backendRepository = backendRepository,
        super(const TracksState()) {
    on<GetFindTrack>(_getFindTrack);
    on<GetMoreTracks>(_getMoreTracks);
    on<GetTracks>(_getTracks);
    on<GetTrack>(_getTrack);
  }

  _getFindTrack(GetFindTrack event, Emitter<TracksState> emitter) async {
    emitter(state.copyWith(trackStatus: TracksStatus.loading));

    var getFindTrackResult = await _backendRepository.getFindTrack(
        Hive.box<User>('userBox').get('user')?.token ?? '', event.name);

    if (getFindTrackResult is NetworkStateFailed) {
      return emitter(state.copyWith(trackStatus: TracksStatus.failure));
    }

    if (getFindTrackResult is NetworkStateSuccess) {
      return emitter(state.copyWith(
        trackStatus: TracksStatus.success,));
    }
  }

  _getMoreTracks(
      GetMoreTracks event, Emitter<TracksState> emitter) async {
    if (state.hasReached) return;

    emitter(state.copyWith(tracksStatus: TracksStatus.loading));

    var tracksResult = await _backendRepository.getMoreTracks(
        Hive.box<User>('userBox').get('user')?.token ?? '', event.page);

    if (tracksResult is NetworkStateFailed) {
      return emitter(state.copyWith(tracksStatus: TracksStatus.failure));
    }

    if (tracksResult is NetworkStateSuccess) {
      Tracks tracks = tracksResult.data?.data != null
          ? Tracks.fromJson(tracksResult.data?.data)
          : Tracks();

      var nextPage = tracks.meta.currentPage < tracks.meta.lastPage
          ? tracks.meta.currentPage + 1
          : tracks.meta.lastPage;

      return emitter(state.copyWith(
          tracksStatus: TracksStatus.success,
          tracks: tracks.data,
          hasReached: tracks.meta.currentPage >= tracks.meta.lastPage,
          currentPage: tracks.meta.currentPage,
          nextPage: nextPage,
          lastPage: tracks.meta.lastPage));
    }
  }

  _getTracks(GetTracks event, Emitter<TracksState> emitter) async {
    emitter(state.copyWith(tracksStatus: TracksStatus.loading));

    var tracksResult = await _backendRepository
        .getTracks(Hive.box<User>('userBox').get('user')?.token ?? '');

    if (tracksResult is NetworkStateFailed) {
      return emitter(state.copyWith(tracksStatus: TracksStatus.failure));
    }

    if (tracksResult is NetworkStateSuccess) {
      Tracks tracks = tracksResult.data?.data != null
          ? Tracks.fromJson(tracksResult.data?.data)
          : Tracks();

      return emitter(state.copyWith(
          tracksStatus: TracksStatus.success, tracks: tracks.data));
    }
  }

  _getTrack(GetTrack event, Emitter<TracksState> emitter) async {
    emitter(state.copyWith(trackStatus: TracksStatus.loading));

    var trackResult = await _backendRepository.getTrack(
        Hive.box<User>('userBox').get('user')?.token ?? '', event.trackId);

    if (trackResult is NetworkStateFailed) {
      return emitter(state.copyWith(trackStatus: TracksStatus.failure));
    }

    if (trackResult is NetworkStateSuccess) {
      Track track = const Track();
      if (trackResult.data!.data['data'] != null) {
        track =
            Track.fromJson(trackResult.data!.data['data']);
      }

      return emitter(state.copyWith(
          trackStatus: TracksStatus.success,
          track: track,));
    }
  }
}
