import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/config/strings.dart';
import 'package:muzzone/generated/locale_keys.g.dart';
import 'package:muzzone/logic/blocs/phone_number_verification/phone_number_verification_bloc.dart';
import 'package:muzzone/logic/blocs/phone_number_verification/phone_number_verification_event.dart';
import 'package:muzzone/logic/blocs/phone_number_verification/phone_number_verification_state.dart';
import 'package:muzzone/ui/pages/main_page/view/main_page.dart';
import 'package:muzzone/ui/pages/player_page/bloc/audio_bloc.dart';
import 'package:muzzone/ui/widgets/layout_widgets/page_layout.dart';
import 'package:sizer/sizer.dart';

import '../../../../logic/blocs/bottom_bar/bottom_bar_bloc.dart';
import '../../../widgets/common_widgets/custom_loader.dart';
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
              Navigator.pushNamed(
                context,
                MainPage.id,
              );
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
  bool isKeyboardVisible = false;
  final bottomBarBloc = GetIt.I.get<BottomBarBloc>();
  final audioBloc = GetIt.I.get<AudioBloc>();

  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomViewInsets = WidgetsBinding.instance.window.viewInsets.bottom;
    isKeyboardVisible = bottomViewInsets > 0;
  }

  // scroll to bottom of screen, when pin input field is in focus.
  Future<void> _scrollToBottomOnKeyboardOpen() async {
    while (!isKeyboardVisible) {
      await Future.delayed(const Duration(milliseconds: 50));
    }

    await Future.delayed(const Duration(milliseconds: 250));

    await scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TempPhoneArguments;

    return SafeArea(child:
        BlocBuilder<PhoneNumberVerificationBloc, PhoneNumberVerificationState>(
            builder: (context, state) {
      if (state.phoneNumberVerificationStatus ==
          PhoneNumberVerificationStatus.loading) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            const CustomLoader(),
            SizedBox(height: 15.h),
            Center(
              child: Text(
                LocaleKeys.spending_sms.tr(),
                style: TextStyle(fontSize: 15.sp),
              ),
            ),
          ],
        );
      }

      return PageLayout(
        needBottomBar: false,
        noSingleScroll: true,
        child: ListView(
          padding: const EdgeInsets.all(20),
          controller: scrollController,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Text(
                LocaleKeys.enter_app.tr(),
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Center(
              child: Text(
                LocaleKeys.sms_spend.tr(),
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Center(
              child: Text(
                args.phoneNumber,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AuthenticationPage.id, (route) => false);
                },
                child: Text(
                  LocaleKeys.want_change_phone.tr(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              LocaleKeys.sms_code.tr(),
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            PinInputField(
              length: 6,
              onFocusChange: (hasFocus) async {
                if (hasFocus) await _scrollToBottomOnKeyboardOpen();
              },
              onSubmit: (enteredOtp) {
                BlocProvider.of<PhoneNumberVerificationBloc>(context).add(
                    PhoneNumberVerified(
                        phoneNumber: args.phoneNumber, authCode: enteredOtp));
              },
            ),
          ],
        ),
      );
    }));
  }

/*FirebasePhoneAuthHandler(
      phoneNumber: args.phoneNumber,
      signOutOnSuccessfulVerification: false,
      linkWithExistingUser: false,
      autoRetrievalTimeOutDuration: const Duration(seconds: 60),
      otpExpirationDuration: const Duration(seconds: 60),
      onCodeSent: () {
        log(VerifyPhoneNumberPage.id, msg: 'OTP sent!');
      },
      onLoginSuccess: (userCredential, autoVerified) async {
        log(
          VerifyPhoneNumberPage.id,
          msg: autoVerified
              ? 'OTP was fetched automatically!'
              : 'OTP was verified manually!',
        );

        showFlutterToast(
            Colors.green, Colors.white, LocaleKeys.successful_enter.tr());

        log(
          VerifyPhoneNumberPage.id,
          msg: 'Login Success UID: ${userCredential.user?.uid}',
        );

        bottomBarBloc.add(ShowBottomBar());
        audioBloc.add(ShowMinHeight());

        Navigator.pushNamedAndRemoveUntil(
          context,
          SplashPage.id,
              (route) => false,
        );
      },
      onLoginFailed: (authException, stackTrace) {
        log(
          VerifyPhoneNumberPage.id,
          msg: authException.message,
          error: authException,
          stackTrace: stackTrace,
        );

        switch (authException.code) {
          case 'invalid-phone-number':
          // invalid phone number
            Navigator.of(context).pushNamedAndRemoveUntil(
                AuthenticationPage.id, (route) => false);
            return showFlutterToast(Colors.red, Colors.white,
                LocaleKeys.invalid_phone_number.tr());

          case 'invalid-verification-code':
          // invalid otp entered
            return showFlutterToast(
                Colors.red, Colors.white, LocaleKeys.invalid_code.tr());
        // handle other error codes
          default:
            Navigator.pop(context);
            return showFlutterToast(Colors.red, Colors.white,
                LocaleKeys.something_went_wrong.tr());

        // handle error further if needed
        }
      },
      onError: (error, stackTrace) {
        log(
          VerifyPhoneNumberPage.id,
          error: error,
          stackTrace: stackTrace,
        );
        showFlutterToast(Colors.red, Colors.white, LocaleKeys.error.tr());
      },
      builder: (context, controller) {
        return PageLayout(
          needBottomBar: false,
          noSingleScroll: true,
          child: controller.isSendingCode
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              const CustomLoader(),
              SizedBox(height: 15.h),
              Center(
                child: Text(
                  LocaleKeys.spending_sms.tr(),
                  style: TextStyle(fontSize: 15.sp),
                ),
              ),
            ],
          )
              : ListView(
            padding: const EdgeInsets.all(20),
            controller: scrollController,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Text(
                  LocaleKeys.enter_app.tr(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Center(
                child: Text(
                  LocaleKeys.sms_spend.tr(),
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              Center(
                child: Text(
                  args.phoneNumber,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        AuthenticationPage.id, (route) => false);
                  },
                  child: Text(
                    LocaleKeys.want_change_phone.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                LocaleKeys.sms_code.tr(),
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.h),
              PinInputField(
                length: 6,
                onFocusChange: (hasFocus) async {
                  if (hasFocus) await _scrollToBottomOnKeyboardOpen();
                },
                onSubmit: (enteredOtp) async {
                  final verified =
                  await controller.verifyOtp(enteredOtp);
                  if (verified) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        LoadingPage.id, (route) => false);
                  } else {
                    // phone verification failed
                    // will call onLoginFailed or onError callbacks with the error
                  }
                },
              ),
              if (controller.codeSent)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.no_code.tr(),
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                    TextButton(
                      onPressed: controller.isOtpExpired
                          ? () async {
                        log(VerifyPhoneNumberPage.id,
                            msg: 'Resend OTP');
                        await controller.sendOTP();
                      }
                          : null,
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: AppColors.primaryColor,
                                ))),
                        child: Text(
                          controller.isOtpExpired
                              ? LocaleKeys.spend_again.tr()
                              : '${LocaleKeys.spend_again.tr()} ${controller.otpExpirationTimeLeft.inSeconds}s',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    ),
  }*/
}
