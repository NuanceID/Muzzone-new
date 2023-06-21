import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:muzzone/ui/widgets/widgets.dart';

import '../../../../../generated/locale_keys.g.dart';

class PrivacyPolicyPage extends StatelessWidget {
  static const id = 'PrivacyPolicyPage';

  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      children: [
        HeaderTitle(
          title: LocaleKeys.privacy_policy.tr(),
        ),
      ],
    );
  }
}
