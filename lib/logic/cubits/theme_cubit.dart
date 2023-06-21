import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzzone/data/local_data_store/local_data_store.dart';

import '../../config/config.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(MuzzoneTheme.lightTheme);

  final LocalDataStore _store = LocalDataStore();

  void chooseLightTheme() {
    _store.setTheme(true);
    emit(MuzzoneTheme.lightTheme);
  }

  void chooseDarkTheme() {
    _store.setTheme(false);
    emit(MuzzoneTheme.darkTheme);
  }
}
