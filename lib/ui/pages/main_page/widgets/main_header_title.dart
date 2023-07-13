import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/config.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../profile/bloc/profile_bloc.dart';
import '../../profile/setting_profile/view/setting_profile_page.dart';

class MainHeaderTitle extends StatelessWidget {
  const MainHeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Flexible(
            fit: FlexFit.tight,
            child: SizedBox.shrink(),
          ),
          Flexible(
            flex: 14,
            fit: FlexFit.tight,
            child: AutoSizeText(
              LocaleKeys.main_page_hello.tr(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18.sp,
                  ),
            ),
          ),
          const Flexible(
            fit: FlexFit.tight,
            child: SizedBox.shrink(),
          ),
        ]),
        SizedBox(
          height: availableHeight/60,
        ),
        Row(
          children: [
            const Flexible(
              fit: FlexFit.tight,
              child: SizedBox.shrink(),
            ),
            Flexible(
              flex: 7,
              fit: FlexFit.tight,
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return AutoSizeText(
                    state.name,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 22.sp,
                        ),
                  );
                },
              ),
            ),
            const Flexible(
              fit: FlexFit.tight,
              child: SizedBox.shrink(),
            ),
            Flexible(
                flex: 6,
                fit: FlexFit.tight,
                child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SettingProfilePage.id);
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: SvgPicture.asset(
                  '${iconsPath}edit.svg',
                  color: Theme.of(context).splashColor,
                  fit: BoxFit.none,
                ),
              ),
            )),
            const Flexible(
              fit: FlexFit.tight,
              child: SizedBox.shrink(),
            ),
          ],
        ),
      ],
    );
  }
}
