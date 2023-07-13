
import 'package:audio_service/audio_service.dart';

class FavouriteAudiosState {
  final List<MediaItem> favouriteList;

  FavouriteAudiosState({this.favouriteList = const <MediaItem>[]});

  FavouriteAudiosState copyWith({
    List<MediaItem>? favouriteList,
  }) {
    return FavouriteAudiosState(
        favouriteList: favouriteList ?? this.favouriteList);
  }
}
