import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/data/data.dart';
import 'package:muzzone/ui/pages/on_board/view/on_boarding_page.dart';
import 'package:muzzone/ui/pages/player_page/bloc/audio_bloc.dart';
import 'package:muzzone/ui/widgets/layout_widgets/page_layout.dart';

import '../../logic/blocs/bottom_bar/bottom_bar_bloc.dart';
import 'main_page/view/main_page.dart';

class LoadingPage extends StatefulWidget {
  static const id = 'LoadingPage';

  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final LocalDataStore _store = LocalDataStore();
  final bottomBarBloc = GetIt.I.get<BottomBarBloc>();
  final audioBloc = GetIt.I.get<AudioBloc>();

  @override
  void initState() {
    startApp();
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
        Navigator.of(context)
            .pushNamedAndRemoveUntil(MainPage.id, (context) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: const Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
