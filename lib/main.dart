import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/data/local_data_store/local_data_store.dart';
import 'package:muzzone/data/models/album.dart';
import 'package:muzzone/data/models/artist.dart';
import 'package:muzzone/data/models/media_item_adapter.dart';
import 'package:muzzone/data/models/playlist.dart';
import 'package:muzzone/data/models/track.dart';
import 'package:muzzone/data/models/user.dart';
import 'package:muzzone/firebase_options.dart';
import 'package:muzzone/generated/codegen_loader.g.dart';
import 'package:muzzone/logic/audio_handler/audio_player_handler.dart';
import 'package:muzzone/logic/cubits/internet_cubit/internet_cubit.dart';
import 'package:muzzone/logic/cubits/theme_cubit.dart';
import 'package:muzzone/ui/pages/start_page.dart';
import 'package:muzzone/ui/widgets/layout_widgets/layout.dart';
import 'package:path_provider/path_provider.dart';

import 'generated/locale_keys.g.dart';

late AudioPlayerHandlerImpl audioHandler;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // latest typeId: 5
  Hive.registerAdapter(MediaItemAdapter());
  Hive.registerAdapter(ArtistAdapter());
  Hive.registerAdapter(AlbumAdapter());
  Hive.registerAdapter(MyPlaylistAdapter());
  Hive.registerAdapter(TrackAdapter());
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

  await Hive.openBox<MyPlaylist>('myPlayLists');
  await Hive.openBox<Track>('recentTracks');
  await Hive.openBox<User>('userBox',
      encryptionCipher: HiveAesCipher(encryptionKeyUint8List));

  await EasyLocalization.ensureInitialized();

  await LocalDataStore.init();

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

  audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandlerImpl(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.uz.telecom.muzzone',
      androidNotificationChannelName: 'Muzzone Audio',
      androidNotificationOngoing: true,
    ),
  );

  runApp(EasyLocalization(
      supportedLocales: const [Locale('ru'), Locale('uz')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ru'),
      assetLoader: const CodegenLoader(),
      child: const MyApp()));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocalDataStore store = LocalDataStore();

    return MultiBlocWrapper(
      child: BlocListener<InternetCubit, ConnectivityResult>(
        listener: listenerInternetConnection,
        child: BlocBuilder<ThemeCubit, ThemeData>(
          builder: (context, state) {
            return MaterialApp(
              builder: (context, child) {
                MediaQueryData mediaQueryData = MediaQuery.of(context);

                double screenWidth = mediaQueryData.size.width;
                double screenHeight = mediaQueryData.size.height;
                double safeAreaPaddingHorizontal =
                    mediaQueryData.padding.left + mediaQueryData.padding.right;
                double safeAreaPaddingVertical =
                    mediaQueryData.padding.top + mediaQueryData.padding.bottom;
                double safeAreaHorizontal =
                    (screenWidth - safeAreaPaddingHorizontal);
                double safeAreaVertical =
                    (screenHeight - safeAreaPaddingVertical);

                ScreenUtil.init(context,
                    designSize: Size(safeAreaHorizontal, safeAreaVertical));

                availableWidth = safeAreaHorizontal;
                availableHeight = safeAreaVertical;

                return Layout(
                  child: child,
                );
              },
              scaffoldMessengerKey: Globals.scaffoldMessengerKey,
              navigatorKey: Globals.kNavigatorKey,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              theme: ThemeGenerator.themeGenerate(store.getTheme()),
              themeMode: ThemeModeGenerator.themeModeGenerate(store.getTheme()),
              debugShowCheckedModeBanner: false,
              title: constantMuzzone,
              initialRoute: StartPage.id,
              onGenerateRoute: (settings) =>
                  RouteGenerator.generateRoute(settings),
            );
          },
        ),
      ),
    );
  }

  void listenerInternetConnection(context, state) {
    if (state == ConnectivityResult.none) {
      showFlutterToast(Colors.red, Colors.white, LocaleKeys.no_internet.tr());
    }
  }
}
