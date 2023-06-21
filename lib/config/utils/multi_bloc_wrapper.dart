import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/logic/blocs/albums/albums_bloc.dart';
import 'package:muzzone/logic/blocs/artists/artists_bloc.dart';
import 'package:muzzone/logic/blocs/authorization/authorization_bloc.dart';
import 'package:muzzone/logic/blocs/categories/categories_bloc.dart';
import 'package:muzzone/logic/blocs/genres/genres_bloc.dart';
import 'package:muzzone/logic/blocs/phone_number_verification/phone_number_verification_bloc.dart';
import 'package:muzzone/logic/blocs/playlists/playlists_bloc.dart';
import 'package:muzzone/logic/blocs/tracks/tracks_bloc.dart';
import 'package:muzzone/ui/pages/my_music/bloc/favourite_audios_bloc.dart';

import '../../logic/blocs/bottom_bar/bottom_bar_bloc.dart';
import '../../logic/blocs/on_boarding/on_board_bloc.dart';
import '../../logic/cubits/internet_cubit/internet_cubit.dart';
import '../../logic/cubits/theme_cubit.dart';
import '../../ui/pages/player_page/bloc/audio_bloc.dart';
import '../../ui/pages/profile/bloc/profile_bloc.dart';
import '../../ui/pages/profile/setting_profile/blocs/support_bloc.dart';
import '../../ui/pages/profile/setting_profile/blocs/track_history_bloc.dart';
import '../../ui/pages/profile/setting_profile/edit_profile_page/widgets/edition_zone/edit_photo/bloc/edit_photo_bloc.dart';

class MultiBlocWrapper extends StatelessWidget {
  MultiBlocWrapper({Key? key, required this.child}) : super(key: key);

  final Widget child;

  final onBoardBloc = GetIt.I.get<OnBoardBloc>();
  final themeCubit = GetIt.I.get<ThemeCubit>();
  final trackHistoryBloc = GetIt.I.get<TrackHistoryBloc>();
  final supportBloc = GetIt.I.get<SupportBloc>();
  final profileBloc = GetIt.I.get<ProfileBloc>();
  final bottomBarBloc = GetIt.I.get<BottomBarBloc>();
  final internetCubit = GetIt.I.get<InternetCubit>();
  final editPhotoBloc = GetIt.I.get<EditPhotoBloc>();
  final audioBloc = GetIt.I.get<AudioBloc>();
  final favouriteAudiosBloc = GetIt.I.get<FavouriteAudiosBloc>();
  final authorizationBloc = GetIt.I.get<AuthorizationBloc>();
  final phoneNumberVerificationBloc =
      GetIt.I.get<PhoneNumberVerificationBloc>();
  final albumsBloc = GetIt.I.get<AlbumsBloc>();
  final artistsBloc = GetIt.I.get<ArtistsBloc>();
  final categoriesBloc = GetIt.I.get<CategoriesBloc>();
  final genresBloc = GetIt.I.get<GenresBloc>();
  final playlistsBloc = GetIt.I.get<PlaylistsBloc>();
  final tracksBloc = GetIt.I.get<TracksBloc>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => onBoardBloc),
      BlocProvider<ThemeCubit>(create: (context) => themeCubit),
      BlocProvider<TrackHistoryBloc>(create: (context) => trackHistoryBloc),
      BlocProvider<SupportBloc>(create: (context) => supportBloc),
      BlocProvider<ProfileBloc>(create: (context) => profileBloc),
      BlocProvider<BottomBarBloc>(create: (context) => bottomBarBloc),
      BlocProvider<InternetCubit>(create: (_) => internetCubit),
      BlocProvider<EditPhotoBloc>(create: (_) => editPhotoBloc),
      BlocProvider<AudioBloc>(create: (_) => audioBloc),
      BlocProvider<FavouriteAudiosBloc>(create: (_) => favouriteAudiosBloc),
      BlocProvider<AuthorizationBloc>(create: (_) => authorizationBloc),
      BlocProvider<PhoneNumberVerificationBloc>(
          create: (_) => phoneNumberVerificationBloc),
      BlocProvider<AlbumsBloc>(create: (_) => albumsBloc),
      BlocProvider<ArtistsBloc>(create: (_) => artistsBloc),
      BlocProvider<CategoriesBloc>(create: (_) => categoriesBloc),
      BlocProvider<GenresBloc>(create: (_) => genresBloc),
      BlocProvider<PlaylistsBloc>(create: (_) => playlistsBloc),
      BlocProvider<TracksBloc>(create: (_) => tracksBloc),
    ], child: child);
  }
}
