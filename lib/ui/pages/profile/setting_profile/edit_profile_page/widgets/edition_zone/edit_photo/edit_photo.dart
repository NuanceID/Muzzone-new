import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../config/style/style.dart';
import '../../../../../../../../generated/locale_keys.g.dart';
import '../../../../../../../widgets/common_widgets/image_widget.dart';

class EditPhoto extends StatelessWidget {
  const EditPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const ImageWidget(
          icon: Icons.add_photo_alternate,
          needFunction: true,
          needBorder: true,
        ),
        SizedBox(
          height: 1.h,
        ),
        Text(
          LocaleKeys.change_photo.tr(),
          style: const TextStyle(
            color: AppColors.greyColor,
          ),
        ),
      ],
    );
  }
}
