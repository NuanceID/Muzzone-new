import 'package:equatable/equatable.dart';
import 'package:muzzone/data/models/playlist.dart';

enum MyPlayListsStatus { initial, success, failure, loading }

class MyPlayListsState extends Equatable {
  final MyPlayListsStatus myPlayListsStatus;
  final List<MyPlaylist> myPlayLists;
  final bool isMyPlayListNameValidated;

  const MyPlayListsState(
      {this.myPlayListsStatus = MyPlayListsStatus.initial,
      this.myPlayLists = const <MyPlaylist>[],
      this.isMyPlayListNameValidated = false});

  @override
  List<Object?> get props => [myPlayListsStatus, myPlayLists, isMyPlayListNameValidated];

  MyPlayListsState copyWith({
    MyPlayListsStatus? myPlayListsStatus,
    List<MyPlaylist>? myPlayLists,
    bool? isMyPlayListNameValidated,
  }) {
    return MyPlayListsState(
      myPlayListsStatus: myPlayListsStatus ?? this.myPlayListsStatus,
      myPlayLists: myPlayLists ?? this.myPlayLists,
      isMyPlayListNameValidated: isMyPlayListNameValidated ?? this.isMyPlayListNameValidated
    );
  }
}
