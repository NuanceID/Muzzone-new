import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muzzone/config/config.dart';
import 'package:volume_controller/volume_controller.dart';

class PlayerVolumeSlider extends StatefulWidget {
  const PlayerVolumeSlider({Key? key}) : super(key: key);

  @override
  State<PlayerVolumeSlider> createState() => _PlayerVolumeSliderState();
}

class _PlayerVolumeSliderState extends State<PlayerVolumeSlider> {
  double _setVolumeValue = 0;

  @override
  void initState() {
    super.initState();
    VolumeController().showSystemUI = false;
    VolumeController().listener((volume) {
      setState(() => _setVolumeValue = volume);
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

    return SizedBox(
      height: availableHeight / 16,
      child: Row(
        children: [
          const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
          Flexible(fit: FlexFit.tight, child: SvgPicture.asset(
            '${iconsPath}volume_off.svg',
          ),),
          Flexible(flex: 6, fit: FlexFit.tight, child: SliderTheme(
            data: SliderThemeData(
              trackHeight: availableHeight / 196,
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: 8.r,
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
                _setVolumeValue = value;
                VolumeController().setVolume(_setVolumeValue);
                setState(() {});
              },
              value: _setVolumeValue,
            ),
          )),
          Flexible(fit: FlexFit.tight, child: SvgPicture.asset(
            '${iconsPath}volume_on.svg',
          ),),
          const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
        ],
      ),
    );
  }
}
