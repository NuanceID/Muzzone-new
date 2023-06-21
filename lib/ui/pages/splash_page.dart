import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/ui/pages/main_page/view/main_page.dart';
import 'package:muzzone/ui/pages/player_page/bloc/audio_bloc.dart';

import '../../config/utils/globals.dart';
import '../../data/local_data_store/local_data_store.dart';
import '../../logic/blocs/bottom_bar/bottom_bar_bloc.dart';
import '../widgets/common_widgets/custom_loader.dart';
import 'on_board/view/on_boarding_page.dart';
import 'start_page.dart';

class SplashPage extends StatefulWidget {
  static const String id = 'SplashPage';

  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final bottomBarBloc = GetIt.I.get<BottomBarBloc>();
  final LocalDataStore _store = LocalDataStore();
  final audioBloc = GetIt.I.get<AudioBloc>();

  @override
  void initState() {
    (() async {
      await Future.delayed(const Duration(milliseconds: 300));
      final isLoggedIn = Globals.firebaseUser != null;

      if (!isLoggedIn) {
        bottomBarBloc.add(HideBottomBar());
        audioBloc.add(HideMinHeight());
        if (!mounted) return;
        Navigator.pushReplacementNamed(
          context,
          StartPage.id,
        );
      } else {
        startApp();
      }
    })();
    super.initState();
  }

  Future<void> startApp() async {
    if (_store.getRegisterDate() == '2022-12-27 09:53:24.989209') {
      _store.setRegisterDate(DateTime.now().toString());
    }

    if (_store.getNeedOnboard()) {
      Future.delayed(const Duration(milliseconds: 100), () {
        bottomBarBloc.add(HideBottomBar());
        audioBloc.add(HideMinHeight());
        Navigator.of(context)
            .pushNamedAndRemoveUntil(OnBoardingPage.id, (context) => false);
      });
    } else {
      Future.delayed(const Duration(milliseconds: 100), () {
        bottomBarBloc.add(ShowBottomBar());
        audioBloc.add(ShowMinHeight());
        audioBloc.add(OpenController());
        Navigator.of(context)
            .pushNamedAndRemoveUntil(MainPage.id, (context) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: CustomLoader(),
      ),
    );
  }
}
