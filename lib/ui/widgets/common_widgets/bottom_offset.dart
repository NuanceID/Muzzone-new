import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muzzone/logic/blocs/audio/audio_state.dart';

import '../../../config/config.dart';
import '../../../logic/blocs/audio/audio_bloc.dart';

class BottomOffset extends StatelessWidget {
  const BottomOffset({Key? key, this.needAnotherHeight = false})
      : super(key: key);

  final bool needAnotherHeight;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        return needAnotherHeight
            ? SizedBox(height: (1.h + Space.bottomBarHeight) * 1.8)
            : SizedBox(height: (4.h + Space.bottomBarHeight) * 1.8);
      },
    );
  }
}
