import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzzone/logic/blocs/favourite_audios/favourite_audios_event.dart';
import 'package:muzzone/logic/blocs/favourite_audios/favourite_audios_state.dart';

class FavouriteAudiosBloc
    extends Bloc<FavouriteAudiosEvent, FavouriteAudiosState> {
  FavouriteAudiosBloc() : super(FavouriteAudiosState()) {}
}
