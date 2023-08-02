import 'package:flutter/material.dart';
import 'package:muzzone/ui/pages/auth/utils/store.dart';
import 'package:phone_number/phone_number.dart';

import '../../ui/pages/auth/view/authentication_page.dart';
import '../../ui/pages/auth/view/verify_phone_number_page.dart';
import '../../ui/pages/on_board/view/on_boarding_page.dart';
import '../../ui/pages/start_page.dart';

Store util = Store(PhoneNumberUtil());

Map<String, Widget Function(BuildContext)> muzzoneRoutes = {
  OnBoardingPage.id: (context) => const OnBoardingPage(),
  StartPage.id: (context) => const StartPage(),
  AuthenticationPage.id: (context) => const AuthenticationPage(),
  VerifyPhoneNumberPage.id: (context) => const VerifyPhoneNumberPage(),
};
