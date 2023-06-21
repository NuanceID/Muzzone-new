import 'package:flutter/material.dart';
import 'package:muzzone/ui/pages/artist/view/artist_page.dart';
import 'package:muzzone/ui/pages/auth/utils/store.dart';
import 'package:muzzone/ui/pages/profile/setting_profile/edit_profile_page/view/edit_profile_page.dart';
import 'package:muzzone/ui/pages/search/widgets/search_special_genre_page/search_special_genres_page.dart';
import 'package:muzzone/ui/pages/show_all_page/show_all_page.dart';
import 'package:phone_number/phone_number.dart';

import '../../ui/pages/album/view/album_page.dart';
import '../../ui/pages/auth/view/authentication_page.dart';
import '../../ui/pages/auth/view/verify_phone_number_page.dart';
import '../../ui/pages/loading_page.dart';
import '../../ui/pages/main_page/view/main_page.dart';
import '../../ui/pages/my_music/view/my_media_library_page.dart';
import '../../ui/pages/my_music/widgets/my_media_page/view/my_media_page.dart';
import '../../ui/pages/on_board/view/on_boarding_page.dart';
import '../../ui/pages/profile/setting_profile/view/setting_profile_page.dart';
import '../../ui/pages/profile/setting_profile/widgets/privacy_policy_page.dart';
import '../../ui/pages/search/view/search_page.dart';
import '../../ui/pages/search/widgets/search_chosen_genre_page/search_chosen_genre_page.dart';
import '../../ui/pages/splash_page.dart';
import '../../ui/pages/start_page.dart';

Store util = Store(PhoneNumberUtil());

Map<String, Widget Function(BuildContext)> muzzoneRoutes = {
  LoadingPage.id: (context) => const LoadingPage(),
  OnBoardingPage.id: (context) => const OnBoardingPage(),
  // '/profile': (context) => const ProfilePage(),
  SettingProfilePage.id: (context) => SettingProfilePage(),
  MainPage.id: (context) => const MainPage(),
  SearchPage.id: (context) => const SearchPage(),
  MyMediaLibraryPage.id: (context) => MyMediaLibraryPage(),
  SearchSpecialGenresPage.id: (context) => SearchSpecialGenresPage(),
  SearchChosenGenrePage.id: (context) => const SearchChosenGenrePage(),
  ShowAllPage.id: (context) => const ShowAllPage(),
  PrivacyPolicyPage.id: (context) => const PrivacyPolicyPage(),
  ArtistPage.id: (context) => const ArtistPage(),
  AlbumPage.id: (context) => AlbumPage(),
  // PlayerPage.id: (context) => PlayerPage(),
  EditProfilePage.id: (context) => EditProfilePage(),
  MyMediaPage.id: (context) => const MyMediaPage(),
  StartPage.id: (context) => const StartPage(),

  SplashPage.id: (context) => const SplashPage(),
  AuthenticationPage.id: (context) => AuthenticationPage(util),
  VerifyPhoneNumberPage.id: (context) => const VerifyPhoneNumberPage(),
};
