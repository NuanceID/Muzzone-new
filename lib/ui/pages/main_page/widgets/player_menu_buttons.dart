import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muzzone/config/constants/constants.dart';
import 'package:muzzone/config/style/style.dart';
import 'package:muzzone/logic/blocs/my_playlists/my_playlists_bloc.dart';
import 'package:muzzone/logic/blocs/my_playlists/my_playlists_event.dart';
import 'package:muzzone/ui/pages/main_page/widgets/add_media_button.dart';

class PlayerMenuButtons extends StatefulWidget {
  const PlayerMenuButtons({super.key});

  @override
  State<PlayerMenuButtons> createState() => _PlayerMenuButtonsState();
}

class _PlayerMenuButtonsState extends State<PlayerMenuButtons> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController()
      ..addListener(() {
        bool contain = BlocProvider.of<MyPlayListsBloc>(context)
                .state
                .myPlayLists
                .firstWhereOrNull((e) =>
                    e.title.trim() == _textEditingController.text.trim()) !=
            null;

        if (_textEditingController.text.isNotEmpty) {
          if (contain) {
            BlocProvider.of<MyPlayListsBloc>(context).add(
                const ValidateMyPlayListName(isMyPlaylistNameValidated: false));
          } else if (!contain) {
            BlocProvider.of<MyPlayListsBloc>(context).add(
                const ValidateMyPlayListName(isMyPlaylistNameValidated: true));
          }
        } else {
          BlocProvider.of<MyPlayListsBloc>(context).add(
              const ValidateMyPlayListName(isMyPlaylistNameValidated: false));
        }
      });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext buildContext) {
    return Row(
      children: [
        const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
        Flexible(
            fit: FlexFit.tight,
            child: Column(
              children: [
                const Flexible(
                    flex: 6, fit: FlexFit.tight, child: SizedBox.shrink()),
                Flexible(
                  flex: 88,
                  fit: FlexFit.tight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.all(availableHeight / 200)),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      overlayColor:
                          MaterialStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.grey.withOpacity(0.1);
                        }
                        return null;
                      }),
                    ),
                    onPressed: () {},
                    child: Column(
                      children: [
                        Flexible(
                            fit: FlexFit.tight,
                            child: SvgPicture.asset(
                              'assets/icons/like.svg',
                              width: availableHeight / 20,
                              height: availableHeight / 20,
                              color: AppColors.greyColor,
                            )),
                      ],
                    ),
                  ),
                ),
                const Flexible(
                    flex: 6, fit: FlexFit.tight, child: SizedBox.shrink()),
              ],
            )),
        const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
        Flexible(
            fit: FlexFit.tight,
            child: ElevatedButton(
              style: ButtonStyle(
                shadowColor: MaterialStateProperty.all(Colors.transparent),
                shape: MaterialStateProperty.all(const CircleBorder()),
                padding: MaterialStateProperty.all(
                    EdgeInsets.all(availableHeight / 200)),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.grey.withOpacity(0.1);
                  }
                  return null;
                }),
              ),
              onPressed: () {},
              child: Column(
                children: [
                  Flexible(
                      fit: FlexFit.tight,
                      child: SvgPicture.asset(
                        'assets/icons/share.svg',
                        width: availableHeight / 22,
                        height: availableHeight / 22,
                        color: AppColors.greyColor,
                      )),
                ],
              ),
            )),
        const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
        Flexible(
            fit: FlexFit.tight,
            child: AddMediaButton(
                from: 'player_menu_buttons',
                textEditingController: _textEditingController)),
        const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
        Flexible(
            fit: FlexFit.tight,
            child: ElevatedButton(
              style: ButtonStyle(
                shadowColor: MaterialStateProperty.all(Colors.transparent),
                shape: MaterialStateProperty.all(const CircleBorder()),
                padding: MaterialStateProperty.all(
                    EdgeInsets.all(availableHeight / 200)),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.grey.withOpacity(0.1);
                  }
                  return null;
                }),
              ),
              onPressed: () {},
              child: Column(
                children: [
                  Flexible(
                      fit: FlexFit.tight,
                      child: SvgPicture.asset(
                        'assets/icons/search.svg',
                        width: availableHeight / 25,
                        height: availableHeight / 25,
                        color: AppColors.greyColor,
                      )),
                ],
              ),
            )),
        const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
      ],
    );
  }
}
