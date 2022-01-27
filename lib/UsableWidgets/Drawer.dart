import 'package:blood_donation/Screens/BloodTypes.dart';
import 'package:blood_donation/Screens/Blood_Donation_Benf.dart';
import 'package:blood_donation/Screens/Mail_Page.dart';
import 'package:blood_donation/Screens/Need_Donation.dart';
import 'package:blood_donation/Screens/home/home_screen.dart';
import 'package:blood_donation/shared/Constants.dart';
import 'package:blood_donation/shared/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../Screens/settings/settings.dart';
import '../Styles/CustomColors.dart';
import '../services/auth.dart';
import '../translations/locale_keys.g.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
    required this.userData,
  }) : super(key: key);
  final userData;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Drawer(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: CustomColors.primaryRedColor,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: height * 0.04,
                    backgroundImage:
                        NetworkImage(userData[Constants.userImageUrl]),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    userData[Constants.userName],
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: CustomColors.primaryRedColor),
              title: Text(
                LocaleKeys.home.tr(),
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              onTap: () {
                navigateTo(context, HomeScreen());
              },
            ),
            //Patients
            ListTile(
              leading: Icon(Icons.info, color: CustomColors.primaryRedColor),
              title: Text(
                LocaleKeys.need_donation.tr(),
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              onTap: () {
                navigateTo(context, Need_Donation());
              },
            ),
            //BloodType Info.
            ListTile(
              leading: Icon(
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
                    builder: (BuildContext context) => BloodTypes(),
                  ),
                );
              },
            ),
            //Info before donation
            ListTile(
              leading: Icon(Icons.info, color: CustomColors.primaryRedColor),
              title: Text(
                LocaleKeys.important_info.tr(),
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              onTap: () {
                navigateTo(context, Blood_Donation_Benf());
              },
            ),
            //Mail
            ListTile(
              leading: Icon(Icons.message, color: CustomColors.primaryRedColor),
              title: Text(
                LocaleKeys.contact_us.tr(),
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              onTap: () {
                navigateTo(context, Mail());
              },
            ),
            //Settings
            ListTile(
              leading:
                  Icon(Icons.settings, color: CustomColors.primaryRedColor),
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
                    ));
              },
            ),
            //Exit App
            ListTile(
                leading:
                    Icon(Icons.logout, color: CustomColors.primaryRedColor),
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
