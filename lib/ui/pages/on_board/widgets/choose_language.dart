import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muzzone/ui/pages/on_board/widgets/row_language.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../../logic/cubits/theme_cubit.dart';

class ChooseLanguage extends StatelessWidget {
  const ChooseLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, state) {
          return Column(
            children: [
              RowLanguage(
                asset: 'assets/images/on_board/oz_language.png',
                locale: 'uz',
                countryName: LocaleKeys.uz_language.tr(),
              ),
              RowLanguage(
                asset: 'assets/images/on_board/ru_language.png',
                locale: 'ru',
                countryName: LocaleKeys.ru_language.tr(),
              ),
            ],
          );
        },
      ),
    );
  }
}
