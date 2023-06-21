import 'dart:developer' as devtools show log;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/config/strings.dart';
import 'package:muzzone/generated/locale_keys.g.dart';
import 'package:muzzone/logic/blocs/authorization/authorization_bloc.dart';
import 'package:muzzone/logic/blocs/authorization/authorization_event.dart';
import 'package:muzzone/logic/blocs/authorization/authorization_state.dart';
import 'package:muzzone/ui/pages/auth/utils/store.dart';
import 'package:muzzone/ui/pages/auth/view/verify_phone_number_page.dart';
import 'package:muzzone/ui/pages/loading_page.dart';
import 'package:muzzone/ui/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../../logic/blocs/bottom_bar/bottom_bar_bloc.dart';
import '../../../../logic/functions/dismiss_keyboard.dart';
import '../models/region.dart';

class AuthenticationPage extends StatelessWidget {
  static const id = 'AuthenticationScreen';

  final Store store;

  const AuthenticationPage(
    this.store, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthorizationBloc, AuthorizationState>(
      listener: (context, state) {
        if (state.authorizationStatus == AuthorizationStatus.success) {

          if(state.serverMessage == authCodeSentSuccessfully) {
            Navigator.pushNamed(
              context,
              VerifyPhoneNumberPage.id,
              arguments: TempPhoneArguments(phoneNumber: state.phoneNumber),
            );
            return;
          }

          if(state.serverMessage == phoneNumberNotFound) {
            showFlutterToast(Colors.red, Colors.white, LocaleKeys.something_went_wrong.tr());
            return;
          }

          showFlutterToast(Colors.red, Colors.white, LocaleKeys.something_went_wrong.tr());
        }

        if (state.authorizationStatus == AuthorizationStatus.failure) {
          showFlutterToast(Colors.red, Colors.white, LocaleKeys.something_went_wrong.tr());
        }
      },
      child: _AuthenticationPage(store),
    );
  }
}

class _AuthenticationPage extends StatefulWidget {
  final Store store;

  const _AuthenticationPage(
    this.store, {
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<_AuthenticationPage>
    with AutomaticKeepAliveClientMixin {
  bool valid = false;
  final ctrl = TextEditingController();
  final bottomBarBloc = GetIt.I.get<BottomBarBloc>();

  Future<void> validate() async {
    if (_formKey.currentState!.validate()) {
      dismissKeyboard(context);

      valid = await widget.store.validate(
        ctrl.text,
        region: Region('UZ', 998, 'Узбекистан'),
      );
      log('isValid : $valid');

      if (!mounted) return;
      showFlutterToast(valid ? Colors.green : Colors.red, Colors.white,
          "${LocaleKeys.validation_status.tr()} ${valid ? LocaleKeys.valid.tr() : LocaleKeys.invalid.tr()}");
      if (valid == false) {
        ctrl.text = '';
      }
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<AuthorizationBloc, AuthorizationState>(
        builder: (context, state) {
      if (state.authorizationStatus == AuthorizationStatus.loading) {
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
              child: Text('',
                style: TextStyle(fontSize: 15.sp),
              ),
            ),
          ],
        );
      }

      return GestureDetector(
        onTap: () => dismissKeyboard(context),
        child: PageLayout(
          needBottomBar: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
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
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Text(
                  LocaleKeys.enter_your_phone.tr(),
                  style: const TextStyle(color: AppColors.greyColor),
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              KeyboardVisibilityBuilder(
                builder: (context, visible) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: ctrl,
                        autocorrect: false,
                        enableSuggestions: false,
                        autofocus: true,
                        decoration: InputDecoration(
                          isDense: true,
                          prefixIcon: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 1.h),
                            width: 40.w,
                            child: Row(
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 0.w, right: 1.w),
                                  width: 35.sp,
                                  height: 27.sp,
                                  padding: EdgeInsets.only(bottom: 0.h),
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        '${imagesPath}uz_flag.png',
                                      ),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0.h),
                                  child: Text(
                                    '+998',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          prefixIconConstraints:
                              const BoxConstraints(minWidth: 0, minHeight: 0),
                          prefixStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          counterText: '',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 0.w, vertical: 3.h),
                        ),
                        cursorColor: !visible
                            ? Theme.of(context).scaffoldBackgroundColor
                            : Theme.of(context).secondaryHeaderColor,
                        enableInteractiveSelection: false,
                        maxLines: 1,
                        enabled: true,
                        maxLength: 14,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                        onTap: () {},
                        onEditingComplete: () async {
                          dismissKeyboard(context);
                          if (ctrl.text.length == 9) {
                            setState(() {
                              valid = true;
                            });
                          }
                        },
                        onChanged: (phone) async {
                          if (phone.length == 9) {
                            dismissKeyboard(context);
                            await validate();
                          } else {
                            if (phone.length > 9) {
                              await validate();
                            }
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: PrimaryButton(
                  onPress: () async {
                    if (ctrl.text == '......') {
                      // Future.delayed(const Duration(milliseconds: 200), () {
                      //   bottomBarBloc.add(ShowBottomBar());
                      // });
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          LoadingPage.id, (route) => false);
                    } else if (isNullOrBlank(ctrl.text) ||
                        !_formKey.currentState!.validate()) {
                      showFlutterToast(Colors.red, Colors.white,
                          LocaleKeys.valid_phone.tr());
                    } else if (valid) {
                      devtools.log('+998${ctrl.text}');
                      BlocProvider.of<AuthorizationBloc>(context)
                          .add(Login(phoneNumber: '+998${ctrl.text}'));
                      /*Navigator.pushNamed(
                      context,
                      VerifyPhoneNumberPage.id,
                      arguments:
                          TempPhoneArguments(phoneNumber: '+998${ctrl.text}'),
                    );*/
                    } else {
                      await validate();
                    }
                  },
                  color: valid ? AppColors.primaryColor : AppColors.greyColor,
                  text: LocaleKeys.spend_code.tr(),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
