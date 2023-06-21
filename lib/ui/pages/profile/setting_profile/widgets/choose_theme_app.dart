import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:muzzone/config/config.dart';
import 'package:sizer/sizer.dart';

import '../../../../../data/data.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../../logic/cubits/theme_cubit.dart';

class ChooseThemeApp extends StatefulWidget {
  const ChooseThemeApp({Key? key}) : super(key: key);

  @override
  State<ChooseThemeApp> createState() => _ChooseThemeAppState();
}

class _ChooseThemeAppState extends State<ChooseThemeApp> {
  final themeCubit = GetIt.I.get<ThemeCubit>();
  final LocalDataStore _store = LocalDataStore();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.theme_app.tr(),
                style: TextStyle(fontSize: 12.sp, color: AppColors.greyColor),
              ),
              SizedBox(
                height: 2.h,
              ),
              ListTile(
                onTap: () => themeCubit.chooseLightTheme(),
                contentPadding: EdgeInsets.zero,
                title: Text(
                  LocaleKeys.light_theme.tr(),
                  style: TextStyle(
                      fontWeight: _store.getTheme() ? FontWeight.bold : null),
                ),
                trailing: _store.getTheme()
                    ? SvgPicture.asset(
                        '${iconsPath}okay.svg',
                      )
                    : null,
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              ),
              ListTile(
                onTap: () => themeCubit.chooseDarkTheme(),
                contentPadding: EdgeInsets.zero,
                title: Text(
                  LocaleKeys.dark_theme.tr(),
                  style: TextStyle(
                      fontWeight: !_store.getTheme() ? FontWeight.bold : null),
                ),
                trailing: !_store.getTheme()
                    ? SvgPicture.asset(
                        '${iconsPath}okay.svg',
                      )
                    : null,
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              ),
            ],
          );
        },
      ),
    );
  }
}
