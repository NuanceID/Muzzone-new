part of 'favourite_audios_bloc.dart';

class FavouriteAudiosState {
  final List<Audio> favouriteList;

  FavouriteAudiosState({required this.favouriteList});

  FavouriteAudiosState copyWith({
    List<Audio>? favouriteList,
  }) {
    return FavouriteAudiosState(
        favouriteList: favouriteList ?? this.favouriteList);
  }
}

class FavouriteAudiosInitial extends FavouriteAudiosState {
  FavouriteAudiosInitial({required super.favouriteList});
}
