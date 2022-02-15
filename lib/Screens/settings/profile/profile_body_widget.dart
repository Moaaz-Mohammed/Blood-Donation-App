import 'package:blood_donation/Screens/settings/profile/profile_card_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../UsableWidgets/custom_sized_box_height.dart';
import '../../../UsableWidgets/loading.dart';
import '../../../shared/Constants.dart';
import '../../../translations/locale_keys.g.dart';

class ProfileBodyWidget extends StatelessWidget {
  const ProfileBodyWidget({
    Key? key,
    required this.userData,
  });

  final userData;

  @override
  Widget build(BuildContext context) {
    return userData != null
        ? ListView(
            padding: Constants.primaryPadding,
            physics: BouncingScrollPhysics(),
            children: [
              CustomSizedBoxHeight(),
              Container(
                padding: Constants.primaryPadding,
                child: Column(
                  children: [
                    ProfileCardItem(
                      title: LocaleKeys.name.tr(),
                      subTitle: userData[Constants.userName],
                    ),
                    Divider(
                      indent: 10.0,
                      endIndent: 10.0,
                    ),
                    ProfileCardItem(
                      title: LocaleKeys.date_of_birth.tr(),
                      subTitle: userData[Constants.userDateofBirth],
                    ),
                    Divider(
                      indent: 10.0,
                      endIndent: 10.0,
                    ),
                    ProfileCardItem(
                      title: LocaleKeys.address.tr(),
                      subTitle: userData[Constants.userAddress],
                    ),
                    Divider(
                      indent: 10.0,
                      endIndent: 10.0,
                    ),
                    ProfileCardItem(
                      title: LocaleKeys.phone.tr(),
                      subTitle: userData[Constants.userPhone],
                    ),
                    Divider(
                      indent: 10.0,
                      endIndent: 10.0,
                    ),
                    ProfileCardItem(
                      title: LocaleKeys.email.tr(),
                      subTitle: userData[Constants.userEmail],
                    ),
                    Divider(
                      indent: 10.0,
                      endIndent: 10.0,
                    ),
                    ProfileCardItem(
                      title: LocaleKeys.blood_type.tr(),
                      subTitle: userData[Constants.userBloodType],
                    ),
                  ],
                ),
              ),
            ],
          )
        : const Loading();
  }
}
