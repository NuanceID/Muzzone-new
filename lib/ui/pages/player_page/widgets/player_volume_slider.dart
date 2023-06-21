import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/ui/pages/player_page/bloc/audio_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:volume_controller/volume_controller.dart';

class PlayerVolumeSlider extends StatefulWidget {
  const PlayerVolumeSlider({Key? key}) : super(key: key);

  @override
  State<PlayerVolumeSlider> createState() => _PlayerVolumeSliderState();
}

class _PlayerVolumeSliderState extends State<PlayerVolumeSlider> {
  double _volumeListenerValue = 0;
  double _getVolume = 0;
  double _setVolumeValue = 0;

  final audioBloc = GetIt.I.get<AudioBloc>();

  @override
  void initState() {
    super.initState();
    VolumeController().showSystemUI = false;

    VolumeController().listener((volume) {
      setState(() => _volumeListenerValue = volume);
    });

    VolumeController().getVolume().then((volume) => _setVolumeValue = volume);
  }

  @override
  void dispose() {
    VolumeController().removeListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 4.h,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            '${iconsPath}volume_off.svg',
          ),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                trackHeight: 4,
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 6,
                ),
                thumbColor: Colors.white,
                inactiveTrackColor: AppColors.greyColor.withOpacity(0.3),
                activeTrackColor: AppColors.greyColor,
                valueIndicatorColor: Colors.yellow,
              ),
              child: Slider(
                min: 0,
                max: 1,
                secondaryActiveColor: Colors.red,
                onChanged: (double value) {
                  // audioBloc.add(BanDrag());
                  _setVolumeValue = value;
                  VolumeController().setVolume(_setVolumeValue);
                  setState(() {});
                },
                value: _setVolumeValue,
                onChangeStart: (double value) {
                  log('00000');
                  // audioBloc.add(BanDrag());
                },
                // onChangeEnd: (double value) {
                //   Future.delayed(const Duration(milliseconds: 50), () {
                //     audioBloc.add(AllowDrag());
                //     log('111111');
                //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //         content: Container(
                //             height: 100, width: 100, color: Colors.red)));
                //   });
                // },
              ),
            ),
          ),
          SvgPicture.asset(
            '${iconsPath}volume_on.svg',
          ),
        ],
      ),
    );
  }
}
