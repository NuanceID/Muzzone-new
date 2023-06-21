import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../widgets/layout_widgets/header_title.dart';
import '../widgets/choose_language.dart';

class SecondOnBoard extends StatelessWidget {
  const SecondOnBoard({Key? key, required this.onPress}) : super(key: key);

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        HeaderTitle(
          title: LocaleKeys.choose_language.tr(),
          onPress: onPress,
        ),
        const ChooseLanguage(),
      ],
    );
  }
}
