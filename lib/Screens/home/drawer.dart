import 'package:blood_donation/Screens/blood_donation_benefits.dart';
import 'package:blood_donation/Screens/blood_types.dart';
import 'package:blood_donation/Screens/mail_page.dart';
import 'package:blood_donation/Screens/need_donation.dart';
import 'package:blood_donation/Screens/settings/profile/profile_screen.dart';
import 'package:blood_donation/UsableWidgets/custom_sized_box_height.dart';
import 'package:blood_donation/shared/Functions.dart';
import 'package:blood_donation/shared/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../Styles/CustomColors.dart';
import '../../Styles/Strings.dart';
import '../../services/auth.dart';
import '../../translations/locale_keys.g.dart';
import '../settings/settings.dart';
import 'home_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
    required this.userData,
  }) : super(key: key);
  final userData;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: CustomColors.primaryRedColor,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 75,
                    color: CustomColors.primaryRedColor,
                  ),
                  CustomSizedBoxHeight(),
                  InkWell(
                    onTap: () {
                      Functions.navigatorPush(
                        context: context,
                        screen: ProfileScreen(userData: userData),
                      );
                    },
                    child: Text(
                      userData[Strings.userName],
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading:
                  const Icon(Icons.home, color: CustomColors.primaryRedColor),
              title: Text(
                LocaleKeys.home.tr(),
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              onTap: () {
                navigateTo(context, const HomeScreen());
              },
            ),
            //Patients
            ListTile(
              leading:
                  const Icon(Icons.info, color: CustomColors.primaryRedColor),
              title: Text(
                LocaleKeys.need_donation.tr(),
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              onTap: () {
                navigateTo(context, const NeedDonation());
              },
            ),
            //BloodType Info.
            ListTile(
              leading: const Icon(
                Icons.bloodtype,
                color: CustomColors.primaryRedColor,
              ),
              title: Text(
                LocaleKeys.blood_types.tr(),
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const BloodTypes(),
                  ),
                );
              },
            ),
            //Info before donation
            ListTile(
              leading:
                  const Icon(Icons.info, color: CustomColors.primaryRedColor),
              title: Text(
                LocaleKeys.important_info.tr(),
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              onTap: () {
                navigateTo(context, const DonationBenefitsScreen());
              },
            ),
            //Mail
            ListTile(
              leading: const Icon(Icons.message,
                  color: CustomColors.primaryRedColor),
              title: Text(
                LocaleKeys.contact_us.tr(),
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              onTap: () {
                navigateTo(context, const Mail());
              },
            ),
            //Settings
            ListTile(
              leading: const Icon(Icons.settings,
                  color: CustomColors.primaryRedColor),
              title: Text(
                LocaleKeys.settings.tr(),
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              onTap: () {
                navigateTo(
                  context,
                  SettingsScreen(
                    userData: userData,
                  ),
                );
              },
            ),

            //Exit App
            ListTile(
                leading: const Icon(Icons.logout,
                    color: CustomColors.primaryRedColor),
                title: Text(
                  LocaleKeys.logout.tr(),
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  Auth auth = Auth();
                  auth.signOut(context: context);
                }),
          ],
        ),
      ),
    );
  }
}
