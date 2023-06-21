import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';

import '../../../../../config/config.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../../logic/cubits/theme_cubit.dart';

class LanguageSetting extends StatefulWidget {
  const LanguageSetting({Key? key}) : super(key: key);

  @override
  State<LanguageSetting> createState() => _LanguageSettingState();
}

class _LanguageSettingState extends State<LanguageSetting> {
  final themeCubit = GetIt.I.get<ThemeCubit>();

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
                LocaleKeys.language_app.tr(),
                style: TextStyle(fontSize: 12.sp, color: AppColors.greyColor),
              ),
              SizedBox(
                height: 2.h,
              ),
              ListTile(
                onTap: () => context.setLocale(const Locale('ru')),
                contentPadding: EdgeInsets.zero,
                title: Text(
                  LocaleKeys.ru_language.tr(),
                  style: TextStyle(
                      fontWeight: context.locale.toString() == 'ru'
                          ? FontWeight.bold
                          : null),
                ),
                trailing: context.locale.toString() == 'ru'
                    ? SvgPicture.asset(
                        '${iconsPath}okay.svg',
                      )
                    : null,
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              ),
              ListTile(
                onTap: () => context.setLocale(const Locale('uz')),
                contentPadding: EdgeInsets.zero,
                title: Text(
                  LocaleKeys.uz_language.tr(),
                  style: TextStyle(
                      fontWeight: context.locale.toString() == 'uz'
                          ? FontWeight.bold
                          : null),
                ),
                trailing: context.locale.toString() == 'uz'
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
