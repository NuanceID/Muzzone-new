import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/style/style.dart';
import '../../../../config/theme/theme.dart';
import '../../../../data/local_data_store/local_data_store.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../logic/cubits/theme_cubit.dart';
import '../../../widgets/layout_widgets/header_title.dart';

class ThirdOnBoard extends StatelessWidget {
  ThirdOnBoard({Key? key, required this.onPress}) : super(key: key);

  final VoidCallback onPress;

  final LocalDataStore _store = LocalDataStore();

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return Column(
      children: [
        HeaderTitle(
          title: LocaleKeys.choose_theme.tr(),
          onPress: onPress,
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: BlocBuilder<ThemeCubit, ThemeData>(
            builder: (context, state) {
              return Column(
                children: [
                  ListTile(
                    onTap: () => themeCubit.chooseLightTheme(),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: MyPadding.horizontalPadding),
                    title: Text(
                      LocaleKeys.light_theme.tr(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: state == MuzzoneTheme.lightTheme
                              ? FontWeight.bold
                              : null),
                    ),
                    trailing: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          100,
                        ),
                        color: state == MuzzoneTheme.lightTheme &&
                                _store.getTheme()
                            ? AppColors.primaryColor
                            : AppColors.disabledTipOnBoard,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () => themeCubit.chooseDarkTheme(),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: MyPadding.horizontalPadding),
                    title: Text(
                      LocaleKeys.dark_theme.tr(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: state == MuzzoneTheme.darkTheme
                              ? FontWeight.bold
                              : null),
                    ),
                    trailing: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          100,
                        ),
                        color: state == MuzzoneTheme.darkTheme ||
                                !_store.getTheme()
                            ? AppColors.primaryColor
                            : AppColors.disabledTipOnBoard,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
