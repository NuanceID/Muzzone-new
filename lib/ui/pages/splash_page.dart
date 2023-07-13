/*
import 'package:flutter/material.dart';
import 'package:muzzone/config/style/style.dart';
import 'package:muzzone/ui/pages/main_page/view/main_page.dart';
import 'package:muzzone/ui/pages/player_page/bloc/audio_bloc.dart';

import '../../data/local_data_store/local_data_store.dart';
import 'on_board/view/on_boarding_page.dart';
import 'start_page.dart';

class SplashPage extends StatefulWidget {
  static const String id = 'SplashPage';

  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final LocalDataStore _store = LocalDataStore();
  final audioBloc = GetIt.I.get<AudioBloc>();

  @override
  void initState() {
    startApp();
    super.initState();
  }

  startApp() {
    if (_store.getRegisterDate() == 'firstStart') {
      _store.setRegisterDate(DateTime.now().toString());
    }

    var isAuth = true;

    if (isAuth) {
      WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.pushReplacementNamed(
          context,
          StartPage.id,
        );
      });

      return;
    }

    if (_store.getNeedOnboard()) {
      WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.of(context)
            .pushNamedAndRemoveUntil(OnBoardingPage.id, (context) => false);
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.of(context)
            .pushNamedAndRemoveUntil(MainPage.id, (context) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(color: AppColors.primaryColor,)
    ],);
  }
}
*/
