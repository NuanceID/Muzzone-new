import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzzone/config/network_state/network_state.dart';
import 'package:muzzone/data/models/backend_playlist.dart';
import 'package:muzzone/data/models/backend_playlists.dart';
import 'package:muzzone/data/models/user.dart';
import 'package:muzzone/data/repositories/remote_repositories/backend_repository.dart';
import 'package:muzzone/logic/blocs/trends/trends_event.dart';
import 'package:muzzone/logic/blocs/trends/trends_state.dart';

class TrendsBloc extends Bloc<TrendsEvent, TrendsState> {
  final BackendRepository _backendRepository;

  TrendsBloc({required BackendRepository backendRepository})
      : _backendRepository = backendRepository,
        super(const TrendsState()) {
    on<GetTrends>(_getTrends);
  }

  _getTrends(GetTrends event, Emitter<TrendsState> emitter) async {
    emitter(state.copyWith(trendsStatus: TrendsStatus.loading));

    var playlistsResult = await _backendRepository
        .getPlaylists(Hive.box<User>('userBox').get('user')?.token ?? '');

    if (playlistsResult is NetworkStateFailed) {
      return emitter(state.copyWith(trendsStatus: TrendsStatus.failure));
    }

    BackendPlaylists playlists = playlistsResult.data?.data != null
        ? BackendPlaylists.fromJson(playlistsResult.data?.data)
        : BackendPlaylists();

    var trendsId = playlists.data
        .firstWhereOrNull((element) => element.name == "В трендах")
        ?.id;

    if (trendsId == null) {
      return emitter(state.copyWith(trendsStatus: TrendsStatus.failure));
    }

    var trendsResult = await _backendRepository.getPlaylist(
        Hive.box<User>('userBox').get('user')?.token ?? '',
        trendsId.toString());

    if (trendsResult is NetworkStateFailed) {
      return emitter(state.copyWith(trendsStatus: TrendsStatus.failure));
    }

    BackendPlaylist trends = const BackendPlaylist();
    if (trendsResult.data!.data['data'] != null) {
      trends = BackendPlaylist.fromJson(trendsResult.data!.data['data']);
    }

    if (trendsResult is NetworkStateSuccess) {
      return emitter(
          state.copyWith(trendsStatus: TrendsStatus.success, trends: trends));
    }
  }
}
