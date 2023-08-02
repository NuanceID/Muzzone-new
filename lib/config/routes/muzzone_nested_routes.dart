import 'package:flutter/material.dart';
import 'package:muzzone/ui/pages/artist/view/artist_page.dart';
import 'package:muzzone/ui/pages/auth/utils/store.dart';
import 'package:muzzone/ui/pages/main_page/view/main_page.dart';
import 'package:muzzone/ui/pages/my_media_page/view/my_media_page.dart';
import 'package:muzzone/ui/pages/profile/setting_profile/edit_profile_page/view/edit_profile_page.dart';
import 'package:muzzone/ui/pages/search/view/search_page.dart';
import 'package:muzzone/ui/pages/search/widgets/search_special_genre_page/search_special_genres_page.dart';
import 'package:muzzone/ui/pages/show_all_page/show_all_page.dart';
import 'package:muzzone/ui/pages/tabbar_view/tabbar_view_page.dart';
import 'package:phone_number/phone_number.dart';

import '../../ui/pages/album/view/album_page.dart';
import '../../ui/pages/profile/setting_profile/view/setting_profile_page.dart';
import '../../ui/pages/profile/setting_profile/widgets/privacy_policy_page.dart';
import '../../ui/pages/search/widgets/search_chosen_genre_page/search_chosen_genre_page.dart';

Store util = Store(PhoneNumberUtil());

Map<String, Widget Function(BuildContext)> muzzoneNestedRoutes = {
  // '/profile': (context) => const ProfilePage(),
  SettingProfilePage.id: (context) => const SettingProfilePage(),
  TabBarViewPage.id : (context) => const TabBarViewPage(),
  MainPage.id: (context) => const MainPage(),
  SearchPage.id: (context) => const SearchPage(),
  //MyMediaLibraryPage.id: (context) => MyMediaLibraryPage(),
  SearchSpecialGenresPage.id: (context) => const SearchSpecialGenresPage(),
  SearchChosenGenrePage.id: (context) => const SearchChosenGenrePage(),
  ShowAllPage.id: (context) => const ShowAllPage(),
  PrivacyPolicyPage.id: (context) => const PrivacyPolicyPage(),
  ArtistPage.id: (context) => const ArtistPage(),
  AlbumPage.id: (context) => const AlbumPage(),
  // PlayerPage.id: (context) => PlayerPage(),
  EditProfilePage.id: (context) => const EditProfilePage(),
  MyMediaPage.id: (context) => const MyMediaPage(),
};
