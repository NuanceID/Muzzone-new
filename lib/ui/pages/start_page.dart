import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/data/local_data_store/local_data_store.dart';

import '../../generated/locale_keys.g.dart';
import 'auth/view/authentication_page.dart';

class StartPage extends StatefulWidget {
  static const id = 'StartPage';

  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final LocalDataStore _store = LocalDataStore();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        visible = !visible;
      });
    });
    super.initState();
  }

  var visible = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
      LocalDataStore store = LocalDataStore();

      DateTime now = DateTime.now();

      if (store.getDurationTimeBetweenPress().isEmpty) {
        store.setDurationTimeBetweenPress(now.toString());
        showFlutterToast(
            AppColors.primaryColor, Colors.white, LocaleKeys.repeat_tap_to_exit.tr());
        return false;
      }

      if (now
          .difference(
          DateTime.parse(store.getDurationTimeBetweenPress()))
          .inSeconds <
          4) {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      } else {
        store.setDurationTimeBetweenPress(now.toString());
        showFlutterToast(
            AppColors.primaryColor, Colors.white, LocaleKeys.repeat_tap_to_exit.tr());
      }
      return false;
    }, child: Column(
      children: [
        Flexible(
          flex: 4,
          fit: FlexFit.tight,
          child: Container(),
        ),
        Flexible(
            flex: 55,
            fit: FlexFit.tight,
            child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                      child: SizedBox.shrink(),
                    ),
                    Flexible(
                        flex: 14,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                _store.getTheme()
                                    ? '${imagesOnBoardPath}on_board.png'
                                    : '${imagesOnBoardPath}on_board_dark.png',
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                          child: Center(
                            child: AvatarGlow(
                              endRadius: availableWidth / 2,
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
                                    shape: BoxShape.circle),
                                // BoxDecoration
                                child: CircleAvatar(
                                  backgroundColor: _store.getTheme()
                                      ? AppColors.testGrey.withOpacity(0.1)
                                      : AppColors.primaryColor,
                                  radius: availableHeight / 3.5,
                                  child: Image.asset(
                                    '${imagesOnBoardPath}logo.png',
                                    fit: BoxFit.contain,
                                    color: Theme.of(context).splashColor,
                                    width: availableHeight / 7,
                                    height: availableHeight / 7,
                                  ),
                                ), // CircleAvatar
                              ), // Container
                            ), // AvatarGlow,
                          ),
                        )),
                    const Flexible(
                      child: SizedBox.shrink(),
                    )
                  ],
                ))),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Container(),
        ),
        Flexible(
            flex: 6,
            fit: FlexFit.tight,
            child: Text(
              LocaleKeys.welcome_to.tr(),
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 19.sp,
                  color: AppColors.primaryColor),
            )),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Container(),
        ),
        Flexible(
          flex: 6,
          fit: FlexFit.tight,
          child: Align(
              alignment: Alignment.topCenter,
              child:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Flexible(flex: 10, child: SizedBox.shrink()),
                Flexible(
                    flex: 80,
                    child: Text.rich(
                      TextSpan(children: [
                        _buildTextSpan('M', true),
                        _buildTextSpan('u', false),
                        _buildTextSpan('ZZ', true),
                        _buildTextSpan('one', false),
                      ]),
                    )),
                const Flexible(flex: 10, child: SizedBox.shrink()),
              ])),
        ),
        Flexible(
          flex: 14,
          fit: FlexFit.tight,
          child: Container(),
        ),
        Flexible(
          flex: 16,
          fit: FlexFit.tight,
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: visible ? 1 : 0,
            child: Row(
              children: [
                Flexible(fit: FlexFit.tight, child: Container()),
                Flexible(
                    flex: 8,
                    fit: FlexFit.tight,
                    child: SizedBox(
                        height: availableHeight / 13,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                AuthenticationPage.id, (context) => false);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                                  return AppColors.primaryColor;
                                }),
                            side: MaterialStateProperty.resolveWith((states) {
                              return const BorderSide(
                                  color: Colors.transparent, width: 0);
                            }),
                            shape: MaterialStateProperty.resolveWith<
                                OutlinedBorder>((_) {
                              return RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r));
                            }),
                          ),
                          child: Text(LocaleKeys.button_start.tr(),
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: const Color(0xffF0F0F0))),
                        ))),
                Flexible(fit: FlexFit.tight, child: Container())
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Container(),
        ),
      ],
    ));
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
