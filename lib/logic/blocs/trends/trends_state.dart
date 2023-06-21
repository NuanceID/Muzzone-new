import 'package:equatable/equatable.dart';
import 'package:muzzone/data/models/backend_playlist.dart';
import 'package:muzzone/data/models/playlist.dart';

enum TrendsStatus { initial, success, failure, loading }

class TrendsState extends Equatable {
  final TrendsStatus trendsStatus;
  final String serverMessage;
  final BackendPlaylist trends;

  const TrendsState(
      {this.trendsStatus = TrendsStatus.initial,
      this.serverMessage = '',
      this.trends = const BackendPlaylist()});

  @override
  List<Object?> get props => [trendsStatus, serverMessage, trends];

  TrendsState copyWith(
      {TrendsStatus? trendsStatus,
      String? serverMessage,
      BackendPlaylist? trends,}) {
    return TrendsState(
        trendsStatus: trendsStatus ?? this.trendsStatus,
        serverMessage: serverMessage ?? this.serverMessage,
        trends: trends ?? this.trends,);
  }
}
