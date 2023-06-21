part of 'favourite_audios_bloc.dart';

@immutable
abstract class FavouriteAudiosEvent {}

class LoadFavouriteAudiosEvent extends FavouriteAudiosEvent {}

class AddOrRemoveEvent extends FavouriteAudiosEvent {
  final int id;

  AddOrRemoveEvent(this.id);
}
