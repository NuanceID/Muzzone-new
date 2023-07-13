import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/config/strings.dart';
import 'package:muzzone/generated/locale_keys.g.dart';
import 'package:muzzone/logic/blocs/phone_number_verification/phone_number_verification_bloc.dart';
import 'package:muzzone/logic/blocs/phone_number_verification/phone_number_verification_event.dart';
import 'package:muzzone/logic/blocs/phone_number_verification/phone_number_verification_state.dart';
import 'package:muzzone/ui/pages/main_page/view/main_page.dart';

import '../../../widgets/common_widgets/pin_input_field.dart';
import 'authentication_page.dart';

class VerifyPhoneNumberPage extends StatelessWidget {
  static const id = 'VerifyPhoneNumberScreen';

  const VerifyPhoneNumberPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneNumberVerificationBloc,
            PhoneNumberVerificationState>(
        listener: (context, state) {
          if (state.phoneNumberVerificationStatus ==
              PhoneNumberVerificationStatus.success) {
            if (state.serverMessage == token) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  MainPage.id, (Route<dynamic> route) => false);
              return;
            }

            if (state.serverMessage == authCodeWrong) {
              showFlutterToast(Colors.red, Colors.white,
                  LocaleKeys.something_went_wrong.tr());
              return;
            }

            showFlutterToast(
                Colors.red, Colors.white, LocaleKeys.something_went_wrong.tr());
          }

          if (state.phoneNumberVerificationStatus ==
              PhoneNumberVerificationStatus.failure) {
            showFlutterToast(
                Colors.red, Colors.white, LocaleKeys.something_went_wrong.tr());
          }
        },
        child: const _VerifyPhoneNumberPage());
  }
}

class _VerifyPhoneNumberPage extends StatefulWidget {
  const _VerifyPhoneNumberPage({
    Key? key,
  }) : super(key: key);

  @override
  State<_VerifyPhoneNumberPage> createState() => _VerifyPhoneNumberPageState();
}

class _VerifyPhoneNumberPageState extends State<_VerifyPhoneNumberPage>
    with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TempPhoneArguments;

    return WillPopScope(onWillPop: () async {
      Navigator.of(context).pushNamedAndRemoveUntil(
          AuthenticationPage.id, (Route<dynamic> route) => false);
      return false;
    }, child: BlocBuilder<PhoneNumberVerificationBloc,
        PhoneNumberVerificationState>(builder: (context, state) {
      if (state.phoneNumberVerificationStatus ==
          PhoneNumberVerificationStatus.loading) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          ],
        );
      }

      return SingleChildScrollView(
          child: SizedBox(
              height: availableHeight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Flexible(
                    flex: 12,
                    fit: FlexFit.tight,
                    child: SizedBox.shrink(),
                  ),
                  Flexible(
                    flex: 5,
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox.shrink(),
                        ),
                        Flexible(
                            flex: 8,
                            child: Text(
                              LocaleKeys.enter_app.tr(),
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 21.sp,
                              ),
                            )),
                        const Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                  const Flexible(
                    flex: 5,
                    fit: FlexFit.tight,
                    child: SizedBox.shrink(),
                  ),
                  Flexible(
                    flex: 5,
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox.shrink(),
                        ),
                        Flexible(
                            flex: 8,
                            fit: FlexFit.tight,
                            child: Text(
                              LocaleKeys.sms_spend.tr(),
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp,
                              ),
                              textAlign: TextAlign.center,
                            )),
                        const Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                  const Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: SizedBox.shrink(),
                  ),
                  Flexible(
                    flex: 6,
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox.shrink(),
                        ),
                        Flexible(
                            flex: 8,
                            fit: FlexFit.tight,
                            child: Text(
                              args.phoneNumber,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 23.sp,
                              ),
                              textAlign: TextAlign.center,
                            )),
                        const Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                  const Flexible(
                    fit: FlexFit.tight,
                    child: SizedBox.shrink(),
                  ),
                  Flexible(
                    flex: 7,
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox.shrink(),
                        ),
                        Flexible(
                            flex: 8,
                            fit: FlexFit.tight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    AuthenticationPage.id, (route) => false);
                              },
                              child: Text(
                                LocaleKeys.want_change_phone.tr(),
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17.sp,
                                    color: const Color(0xff3D6394)),
                              ),
                            )),
                        const Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                  const Flexible(
                    flex: 5,
                    fit: FlexFit.tight,
                    child: SizedBox.shrink(),
                  ),
                  Flexible(
                    flex: 5,
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox.shrink(),
                        ),
                        Flexible(
                            flex: 8,
                            fit: FlexFit.tight,
                            child: Text(
                              LocaleKeys.sms_code.tr(),
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                              ),
                            )),
                        const Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                  const Flexible(
                    fit: FlexFit.tight,
                    child: SizedBox.shrink(),
                  ),
                  Flexible(
                    flex: 8,
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox.shrink(),
                        ),
                        Flexible(
                            flex: 8,
                            child: PinInputField(
                              length: 6,
                              onSubmit: (enteredOtp) {
                                BlocProvider.of<PhoneNumberVerificationBloc>(
                                    context)
                                    .add(PhoneNumberVerified(
                                    phoneNumber: args.phoneNumber,
                                    authCode: enteredOtp));
                              },
                            )),
                        const Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                  const Flexible(
                    flex: 48,
                    fit: FlexFit.tight,
                    child: SizedBox.shrink(),
                  ),
                ],
              )));
    }));
  }
}
