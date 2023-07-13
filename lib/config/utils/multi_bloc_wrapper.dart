import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:muzzone/data/repositories/remote_repositories/backend_repository.dart';
import 'package:muzzone/logic/blocs/authorization/authorization_bloc.dart';
import 'package:muzzone/logic/blocs/categories/categories_bloc.dart';
import 'package:muzzone/logic/blocs/favourite_audios/favourite_audios_bloc.dart';
import 'package:muzzone/logic/blocs/genres/genres_bloc.dart';
import 'package:muzzone/logic/blocs/input_validator/input_validator_bloc.dart';
import 'package:muzzone/logic/blocs/phone_number_verification/phone_number_verification_bloc.dart';
import 'package:muzzone/logic/blocs/playlists/playlists_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../logic/blocs/on_boarding/on_board_bloc.dart';
import '../../logic/cubits/internet_cubit/internet_cubit.dart';
import '../../logic/cubits/theme_cubit.dart';
import '../../logic/blocs/audio/audio_bloc.dart';
import '../../ui/pages/profile/bloc/profile_bloc.dart';
import '../../ui/pages/profile/setting_profile/blocs/support_bloc.dart';
import '../../ui/pages/profile/setting_profile/blocs/track_history_bloc.dart';
import '../../ui/pages/profile/setting_profile/edit_profile_page/widgets/edition_zone/edit_photo/bloc/edit_photo_bloc.dart';

class MultiBlocWrapper extends StatelessWidget {
  const MultiBlocWrapper({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<BackendRepository>(
              create: (context) => BackendRepository())
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider(create: (buildContext) => OnBoardBloc()),
          BlocProvider<ThemeCubit>(create: (buildContext) => ThemeCubit()),
          BlocProvider<TrackHistoryBloc>(
              create: (buildContext) => TrackHistoryBloc()),
          BlocProvider<SupportBloc>(create: (buildContext) => SupportBloc()),
          BlocProvider<ProfileBloc>(create: (buildContext) => ProfileBloc()),
          BlocProvider<InternetCubit>(
              create: (buildContext) =>
                  InternetCubit(connectivity: Connectivity())),
          BlocProvider<EditPhotoBloc>(
              create: (buildContext) => EditPhotoBloc()),
          BlocProvider<AudioBloc>(
              create: (buildContext) =>
                  AudioBloc(justAudioPlayer: AudioPlayer(), panelController: PanelController())),
          BlocProvider<FavouriteAudiosBloc>(
              create: (buildContext) => FavouriteAudiosBloc()),
          BlocProvider<AuthorizationBloc>(
              create: (buildContext) => AuthorizationBloc(
                  backendRepository: buildContext.read<BackendRepository>())),
          BlocProvider<PhoneNumberVerificationBloc>(
              create: (buildContext) => PhoneNumberVerificationBloc(
                  backendRepository: buildContext.read<BackendRepository>())),
          BlocProvider<InputValidatorBloc>(
              create: (buildContext) => InputValidatorBloc()),
          BlocProvider<GenresBloc>(create: (buildContext) => GenresBloc(backendRepository: buildContext.read<BackendRepository>())),
          BlocProvider<PlaylistsBloc>(create: (buildContext) => PlaylistsBloc(backendRepository: buildContext.read<BackendRepository>())),
          BlocProvider<CategoriesBloc>(create: (buildContext) => CategoriesBloc(backendRepository: buildContext.read<BackendRepository>()))
        ], child: child));
  }
}
