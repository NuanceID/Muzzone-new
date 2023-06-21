import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/data/data.dart';
import 'package:muzzone/ui/pages/splash_page.dart';
import 'package:muzzone/ui/widgets/layout_widgets/layout.dart';
import 'package:sizer/sizer.dart';

import 'generated/locale_keys.g.dart';
import 'logic/cubits/internet_cubit/internet_cubit.dart';
import 'logic/cubits/theme_cubit.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final LocalDataStore _store = LocalDataStore();

  @override
  Widget build(BuildContext context) {
    return MultiBlocWrapper(
      child: Sizer(
        builder: (context, orientation, deviceType) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          return BlocListener<InternetCubit, ConnectivityResult>(
            listener: listenerInternetConnection,
            child: BlocBuilder<ThemeCubit, ThemeData>(
              builder: (context, state) {
                return FirebasePhoneAuthProvider(
                  child: MaterialApp(
                    builder: (context, child) => Layout(
                      kNavigatorKey: Globals.kNavigatorKey,
                      child: child,
                    ),
                    scaffoldMessengerKey: Globals.scaffoldMessengerKey,
                    navigatorKey: Globals.kNavigatorKey,
                    locale: context.locale,
                    supportedLocales: context.supportedLocales,
                    localizationsDelegates: context.localizationDelegates,
                    theme: ThemeGenerator.themeGenerate(_store.getTheme()),
                    themeMode:
                        ThemeModeGenerator.themeModeGenerate(_store.getTheme()),
                    debugShowCheckedModeBanner: false,
                    title: constantMuzzone,
                    initialRoute: SplashPage.id,
                    onGenerateRoute: (settings) =>
                        RouteGenerator.generateRoute(settings),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void listenerInternetConnection(context, state) {
    if (state == ConnectivityResult.none) {
      showFlutterToast(Colors.red, Colors.white, LocaleKeys.no_internet.tr());
    }
  }
}
