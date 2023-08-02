/*
import 'package:flutter/material.dart';
import 'package:muzzone/data/data.dart';
import 'package:muzzone/ui/pages/on_board/view/on_boarding_page.dart';
import 'package:muzzone/ui/pages/player_page/bloc/audio_bloc.dart';

import 'main_page/view/main_page.dart';

class LoadingPage extends StatefulWidget {
  static const id = 'LoadingPage';

  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final LocalDataStore _store = LocalDataStore();
  final audioBloc = GetIt.I.get<AudioBloc>();

  @override
  void initState() {
    startApp();
    super.initState();
  }

  Future<void> startApp() async {
    if (_store.getRegisterDate() == 'firstStart') {
      _store.setRegisterDate(DateTime.now().toString());
    }

    if (_store.getNeedOnboard()) {
      audioBloc.add(HideMinHeight());
      Navigator.of(context)
          .pushNamedAndRemoveUntil(OnBoardingPage.id, (context) => false);
    } else {
      audioBloc.add(ShowMinHeight());
      Navigator.of(context)
          .pushNamedAndRemoveUntil(MainPage.id, (context) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: const [
      Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
    ]);
  }
}
*/
