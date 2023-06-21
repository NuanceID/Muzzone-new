import 'package:avatar_glow/avatar_glow.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/data/data.dart';
import 'package:muzzone/ui/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../generated/locale_keys.g.dart';
import 'auth/view/authentication_page.dart';

class StartPage extends StatefulWidget {
  static const id = 'StartPage';

  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool loading = true;
  final LocalDataStore _store = LocalDataStore();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _visible = !_visible;
      });
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  var _visible = false;

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      noSingleScroll: true,
      needAnotherBottomHeight: true,
      children: [
        SizedBox(
          height: 13.h,
        ),
        Center(
          child: Container(
            height: 80.w,
            width: 80.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  _store.getTheme()
                      ? '${imagesOnBoardPath}on_board.png'
                      : '${imagesOnBoardPath}on_board_dark.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: AvatarGlow(
                endRadius: 50.w,
                duration: const Duration(seconds: 1),
                glowColor: AppColors.primaryColor,
                repeat: true,
                repeatPauseDuration: const Duration(seconds: 1),
                startDelay: const Duration(seconds: 1),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        style: BorderStyle.none,
                      ), // Border.all
                      shape: BoxShape.circle), // BoxDecoration
                  child: CircleAvatar(
                    backgroundColor: _store.getTheme()
                        ? AppColors.testGrey.withOpacity(0.1)
                        : AppColors.primaryColor, // Container
                    radius: 40.w,
                    child: Image.asset(
                      '${imagesOnBoardPath}logo.png',
                      fit: BoxFit.none,
                      color: Theme.of(context).splashColor,
                    ),
                  ), // CircleAvatar
                ), // Container
              ), // AvatarGlow,
            ),
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        AnimatedOpacity(
          duration: const Duration(seconds: 1),
          opacity: _visible ? 0 : 1,
          child: Center(
            child: Text(
              LocaleKeys.welcome_to.tr(),
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Center(
          child: Text.rich(
            TextSpan(children: [
              _buildTextSpan('M', true),
              _buildTextSpan('u', false),
              _buildTextSpan('ZZ', true),
              _buildTextSpan('one', false),
            ]),
          ),
        ),
        const Spacer(),
        AnimatedOpacity(
          duration: const Duration(seconds: 1),
          opacity: _visible ? 1 : 0,
          child: PrimaryButton(
            onPress: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AuthenticationPage.id, (context) => false);
            },
            color: AppColors.primaryColor,
            text: LocaleKeys.button_start.tr(),
          ),
        ),
      ],
    );
  }

  TextSpan _buildTextSpan(text, bold) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontSize: bold ? 25.sp : 23.sp,
        color: AppColors.primaryColor,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
