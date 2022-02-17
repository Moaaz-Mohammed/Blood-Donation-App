import 'package:blood_donation/Screens/settings/profile/profile_body_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../translations/locale_keys.g.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
    required this.userData,
  }) : super(key: key);

  final userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.profile.tr(),
        ),
      ),
      body: ProfileBodyWidget(
        userData: userData,
      ),
    );
  }
}
