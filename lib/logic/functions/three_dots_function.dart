import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import '../../ui/widgets/layout_widgets/my_bottom_sheet.dart';

Future threeDotsFunction(
    BuildContext context, Audio audio, String fromPage) async {
  showModalBottomSheet(
    isScrollControlled: true,
    useRootNavigator: true,
    context: context,
    backgroundColor: Colors.white.withOpacity(
      0,
    ),
    builder: (context) => MyBottomSheet(
      fromPage: fromPage,
      item: audio,
    ),
  );
}
