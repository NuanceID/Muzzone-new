import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzzone/data/repositories/remote_repositories/backend_repository.dart';
import 'package:muzzone/firebase_options.dart';
import 'package:muzzone/logic/blocs/albums/albums_bloc.dart';
import 'package:muzzone/logic/blocs/artists/artists_bloc.dart';
import 'package:muzzone/logic/blocs/authorization/authorization_bloc.dart';
import 'package:muzzone/logic/blocs/categories/categories_bloc.dart';
import 'package:muzzone/logic/blocs/genres/genres_bloc.dart';
import 'package:muzzone/logic/blocs/phone_number_verification/phone_number_verification_bloc.dart';
import 'package:muzzone/logic/blocs/playlists/playlists_bloc.dart';
import 'package:muzzone/logic/blocs/tracks/tracks_bloc.dart';
import 'package:muzzone/logic/cubits/internet_cubit/internet_cubit.dart';
import 'package:muzzone/ui/controllers/controllers.dart';
import 'package:muzzone/ui/pages/my_music/bloc/favourite_audios_bloc.dart';
import 'package:muzzone/ui/pages/player_page/bloc/audio_bloc.dart';
import 'package:muzzone/ui/pages/profile/bloc/profile_bloc.dart';
import 'package:muzzone/ui/pages/profile/setting_profile/blocs/support_bloc.dart';
import 'package:muzzone/ui/pages/profile/setting_profile/blocs/track_history_bloc.dart';
import 'package:muzzone/ui/pages/profile/setting_profile/edit_profile_page/widgets/edition_zone/edit_photo/bloc/edit_photo_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'data/data.dart';
import 'generated/codegen_loader.g.dart';
import 'logic/blocs/bottom_bar/bottom_bar_bloc.dart';
import 'logic/blocs/on_boarding/on_board_bloc.dart';
import 'logic/cubits/theme_cubit.dart';
import 'my_app.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
  }
}

void startApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //latest typeId: 0

  Hive.registerAdapter(UserAdapter());

  var dir = await getApplicationDocumentsDirectory();

  await Hive.initFlutter(dir.path);

  const secureStorage = FlutterSecureStorage();
  final encryptionKeyString = await secureStorage.read(key: 'userBoxKey');
  if (encryptionKeyString == null) {
    final key = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'userBoxKey',
      value: base64UrlEncode(key),
    );
  }
  final key = await secureStorage.read(key: 'userBoxKey');
  final encryptionKeyUint8List = base64Url.decode(key!);

  await Hive.openBox('Recentsearch');
  await Hive.openBox('RecentlyPlayed');
  await Hive.openBox('playlists');
  await Hive.openBox<User>('userBox',
      encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
  await EasyLocalization.ensureInitialized();
  await LocalDataStore.init();
  Connectivity connectivity = Connectivity();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('Got a message whilst in the foreground!');
    }
    if (kDebugMode) {
      print('Message data: ${message.data}');
    }

    if (message.notification != null) {
      if (kDebugMode) {
        print('Message also contained a notification: ${message.notification}');
      }
    }
  });

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    if (kDebugMode) {
      print('User granted permission');
    }
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    if (kDebugMode) {
      print('User granted provisional permission');
    }
  } else {
    if (kDebugMode) {
      print('User declined or has not accepted permission');
    }
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  GetIt.instance.registerLazySingleton(() => BackendRepository());

  GetIt.instance
    ..registerSingleton<OnBoardBloc>(OnBoardBloc())
    ..registerSingleton<ThemeCubit>(ThemeCubit())
    ..registerSingleton<TrackHistoryBloc>(TrackHistoryBloc())
    ..registerSingleton<SupportBloc>(SupportBloc())
    ..registerSingleton<ProfileBloc>(ProfileBloc())
    ..registerSingleton<BottomBarBloc>(BottomBarBloc())
    ..registerSingleton<EditPhotoBloc>(EditPhotoBloc())
    ..registerSingleton<AudioBloc>(AudioBloc())
    ..registerSingleton<MainController>(MainController()..init())
    ..registerSingleton<FavouriteAudiosBloc>(
        FavouriteAudiosBloc()..add(LoadFavouriteAudiosEvent()))
    ..registerSingleton<InternetCubit>(
        InternetCubit(connectivity: connectivity))
    ..registerSingleton<AuthorizationBloc>(
        AuthorizationBloc(backendRepository: GetIt.I.get<BackendRepository>()))
    ..registerSingleton<PhoneNumberVerificationBloc>(
        PhoneNumberVerificationBloc(backendRepository: GetIt.I.get<BackendRepository>()))
    ..registerSingleton<AlbumsBloc>(
        AlbumsBloc(backendRepository: GetIt.I.get<BackendRepository>()))
    ..registerSingleton<ArtistsBloc>(
        ArtistsBloc(backendRepository: GetIt.I.get<BackendRepository>()))
    ..registerSingleton<CategoriesBloc>(
        CategoriesBloc(backendRepository: GetIt.I.get<BackendRepository>()))
    ..registerSingleton<GenresBloc>(
        GenresBloc(backendRepository: GetIt.I.get<BackendRepository>()))
    ..registerSingleton<PlaylistsBloc>(
        PlaylistsBloc(backendRepository: GetIt.I.get<BackendRepository>()))
    ..registerSingleton<TracksBloc>(
        TracksBloc(backendRepository: GetIt.I.get<BackendRepository>()));

  runApp(EasyLocalization(
      supportedLocales: const [Locale('ru'), Locale('uz')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ru'),
      assetLoader: const CodegenLoader(),
      child: MyApp()));
}
