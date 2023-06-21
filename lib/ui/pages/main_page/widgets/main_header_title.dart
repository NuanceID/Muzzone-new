import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzzone/data/models/user.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/config.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../logic/blocs/bottom_bar/bottom_bar_bloc.dart';
import '../../profile/bloc/profile_bloc.dart';
import '../../profile/setting_profile/view/setting_profile_page.dart';

class MainHeaderTitle extends StatelessWidget {
  MainHeaderTitle({Key? key}) : super(key: key);

  final profileBloc = GetIt.I.get<ProfileBloc>();
  final bottomBarBloc = GetIt.I.get<BottomBarBloc>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MyPadding.horizontalPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          MainHeaderTitleText(),
          MainHeaderTitleIcon(),
        ],
      ),
    );
  }
}

class MainHeaderTitleText extends StatelessWidget {
  const MainHeaderTitleText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.main_page_hello.tr(),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 2.h,
              ),
        ),
        SizedBox(
          height: 0.8.h,
        ),
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return Text(
              state.name,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 17.5.sp,
                  ),
            );
          },
        ),
      ],
    );
  }
}

class MainHeaderTitleIcon extends StatelessWidget {
  const MainHeaderTitleIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SettingProfilePage.id);
      },
      child: Container(
        height: 40.sp,
        width: 40.sp,
        color: Colors.redAccent.withOpacity(0),
        child: Align(
          alignment: Alignment.centerRight,
          child: SvgPicture.asset(
            '${iconsPath}edit.svg',
            color: Theme.of(context).splashColor,
            fit: BoxFit.none,
          ),
        ),
      ),
    );
  }
}
