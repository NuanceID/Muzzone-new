import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/config/strings.dart';
import 'package:muzzone/data/local_data_store/local_data_store.dart';
import 'package:muzzone/generated/locale_keys.g.dart';
import 'package:muzzone/logic/blocs/authorization/authorization_bloc.dart';
import 'package:muzzone/logic/blocs/authorization/authorization_event.dart';
import 'package:muzzone/logic/blocs/authorization/authorization_state.dart';
import 'package:muzzone/logic/blocs/input_validator/input_validator_bloc.dart';
import 'package:muzzone/logic/blocs/input_validator/input_validator_event.dart';
import 'package:muzzone/logic/blocs/input_validator/input_validator_state.dart';

import 'package:muzzone/ui/pages/auth/view/verify_phone_number_page.dart';

class AuthenticationPage extends StatelessWidget {
  static const id = 'AuthenticationScreen';

  const AuthenticationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          LocalDataStore store = LocalDataStore();

          DateTime now = DateTime.now();

          if (store.getDurationTimeBetweenPress().isEmpty) {
            store.setDurationTimeBetweenPress(now.toString());
            showFlutterToast(AppColors.primaryColor, Colors.white,
                LocaleKeys.repeat_tap_to_exit.tr());
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
            showFlutterToast(AppColors.primaryColor, Colors.white,
                LocaleKeys.repeat_tap_to_exit.tr());
          }
          return false;
        },
        child: BlocListener<AuthorizationBloc, AuthorizationState>(
          listener: (context, state) {
            if (state.authorizationStatus == AuthorizationStatus.success) {
              if (state.serverMessage == authCodeSentSuccessfully) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    VerifyPhoneNumberPage.id, (Route<dynamic> route) => false,
                    arguments:
                        TempPhoneArguments(phoneNumber: state.phoneNumber));
                return;
              }

              if (state.serverMessage == phoneNumberNotFound) {
                showFlutterToast(Colors.red, Colors.white,
                    LocaleKeys.something_went_wrong.tr());
                return;
              }

              showFlutterToast(Colors.red, Colors.white,
                  LocaleKeys.something_went_wrong.tr());
            }

            if (state.authorizationStatus == AuthorizationStatus.failure) {
              showFlutterToast(Colors.red, Colors.white,
                  LocaleKeys.something_went_wrong.tr());
            }
          },
          child: const _AuthenticationPage(),
        ));
  }
}

class _AuthenticationPage extends StatefulWidget {
  const _AuthenticationPage();

  @override
  State<_AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<_AuthenticationPage> {
  late TextEditingController ctrl;

  @override
  void initState() {
    super.initState();
    ctrl = TextEditingController()
      ..addListener(() {
        if (ctrl.text.length == 9) {
          BlocProvider.of<InputValidatorBloc>(context)
              .add(const InputValidatorValidate(isPhoneNumberValid: true));
        } else {
          BlocProvider.of<InputValidatorBloc>(context)
              .add(const InputValidatorValidate(isPhoneNumberValid: false));
        }
      });
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizationBloc, AuthorizationState>(
        builder: (context, state) {
      if (state.authorizationStatus == AuthorizationStatus.loading) {
        return Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              ],
            ));
      }

      if (state.authorizationStatus == AuthorizationStatus.success) {
        return Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              ],
            ));
      }

      return SingleChildScrollView(
          child: Container(
        color: Colors.white,
        height: availableHeight,
        child: Column(
          children: [
            const Flexible(
                flex: 10, fit: FlexFit.tight, child: SizedBox.shrink()),
            Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: Row(
                  children: [
                    const Flexible(
                      fit: FlexFit.tight,
                      child: SizedBox.shrink(),
                    ),
                    Flexible(
                      flex: 8,
                      fit: FlexFit.tight,
                      child: Text(
                        LocaleKeys.enter_app.tr(),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 21.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Flexible(
                      fit: FlexFit.tight,
                      child: SizedBox.shrink(),
                    ),
                  ],
                )),
            const Flexible(
                flex: 12, fit: FlexFit.tight, child: SizedBox.shrink()),
            Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: Row(
                  children: [
                    const Flexible(
                        flex: 2, fit: FlexFit.tight, child: SizedBox.shrink()),
                    Flexible(
                      flex: 30,
                      fit: FlexFit.tight,
                      child: Text(LocaleKeys.enter_your_phone.tr(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              color: AppColors.greyColor)),
                    ),
                    const Flexible(
                        flex: 2, fit: FlexFit.tight, child: SizedBox.shrink()),
                  ],
                )),
            const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
            Flexible(
                flex: 10,
                child: Row(
                  children: [
                    const Flexible(
                        flex: 2, fit: FlexFit.tight, child: SizedBox.shrink()),
                    Flexible(
                      flex: 30,
                      fit: FlexFit.tight,
                      child: TextFormField(
                        autofocus: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: ctrl,
                        autocorrect: false,
                        enableSuggestions: false,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                            color: Colors.black,
                            letterSpacing: 2),
                        decoration: InputDecoration(
                          prefix: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: SizedBox.shrink()),
                              Flexible(
                                flex: 50,
                                fit: FlexFit.tight,
                                child: Image.asset(
                                  '${imagesPath}uz_flag.png',
                                  fit: BoxFit.fitHeight,
                                  height: availableHeight / 16,
                                ),
                              ),
                              const Flexible(
                                  flex: 20,
                                  fit: FlexFit.tight,
                                  child: SizedBox.shrink()),
                              Flexible(
                                flex: 200,
                                child: Text(
                                  '+998',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp,
                                      color: Colors.black),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              const Flexible(
                                  flex: 5,
                                  fit: FlexFit.tight,
                                  child: SizedBox.shrink()),
                            ],
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.w, color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(13.0.r),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.w, color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(13.0.r),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.w, color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(13.0.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.w, color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(13.0.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.w, color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(13.0.r),
                          ),
                          counterText: '',
                        ),
                        cursorColor: Theme.of(context).secondaryHeaderColor,
                        maxLines: 1,
                        maxLength: 9,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const Flexible(
                        flex: 2, fit: FlexFit.tight, child: SizedBox.shrink()),
                  ],
                )),
            const Flexible(
                flex: 4, fit: FlexFit.tight, child: SizedBox.shrink()),
            Flexible(
                flex: 7,
                child: Row(
                  children: [
                    const Flexible(
                        fit: FlexFit.tight, child: SizedBox.shrink()),
                    Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: BlocBuilder<InputValidatorBloc,
                            InputValidatorState>(
                          builder: (context, state) {
                            return SizedBox.expand(
                                child: OutlinedButton(
                              onPressed: state.isPhoneNumberValid
                                  ? () {
                                      BlocProvider.of<AuthorizationBloc>(
                                              context)
                                          .add(Login(
                                              phoneNumber: '+998${ctrl.text}'));
                                    }
                                  : null,
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (states) {
                                  return state.isPhoneNumberValid
                                      ? AppColors.primaryColor
                                      : const Color(0xff90959B);
                                }),
                                side:
                                    MaterialStateProperty.resolveWith((states) {
                                  return const BorderSide(
                                      color: Colors.transparent, width: 0);
                                }),
                                shape: MaterialStateProperty.resolveWith<
                                    OutlinedBorder>((_) {
                                  return RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.r));
                                }),
                              ),
                              child: Text(LocaleKeys.spend_code.tr(),
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                      color: const Color(0xffF0F0F0))),
                            ));
                          },
                        )),
                    const Flexible(
                        fit: FlexFit.tight, child: SizedBox.shrink()),
                  ],
                )),
            const Flexible(
                flex: 50, fit: FlexFit.tight, child: SizedBox.shrink()),
          ],
        ),
      ));
    });
  }
}
