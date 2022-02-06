import 'package:blood_donation/Screens/settings/change_language_dialog.dart';
import 'package:blood_donation/Screens/settings/profile/profile_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../Styles/CustomColors.dart';
import '../../UsableWidgets/ArrowBox.dart';
import '../../UsableWidgets/custom_sized_box_height.dart';
import '../../UsableWidgets/custom_sized_box_width.dart';
import '../../shared/Constants.dart';
import '../../shared/Functions.dart';
import '../../state_management/bloc/Cubit.dart';
import '../../translations/locale_keys.g.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    Key? key,
    required this.userData,
  }) : super(key: key);
  final userData;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.settings.tr()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.settings.tr(),
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Text(
                  LocaleKeys.account.tr(),
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: size.width * 0.08,
                    backgroundImage:
                    userData[Constants.userImageUrl] == null
                        ? AssetImage(
                      Constants.addUserImage,
                    ) as ImageProvider
                        : NetworkImage(
                      userData[Constants.userImageUrl],
                    ),
                  ),
                  title: Text(
                    userData[Constants.userName],
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  subtitle: Text(
                    LocaleKeys.personal_info.tr(),
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  trailing: ArrowBox(
                      icon: Icons.chevron_right,
                      onPressed: () {
                        Functions.navigatorPush(
                            context: context,
                            screen: ProfileScreen(userData: userData));
                      }),
                ),
                SizedBox(
                  height: size.height * 0.045,
                ),
                Text(
                  LocaleKeys.settings.tr(),
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: size.width * 0.06,
                      child: Icon(Icons.language,
                          color: CustomColors.primaryWhiteColor),
                    ),
                    CustomSizedBoxWidth(),
                    InkWell(
                      onTap: () {
                        change_language_dialog(context);
                      },
                      onDoubleTap: () async {},
                      child: Text(
                        LocaleKeys.change_language.tr(),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: size.width * 0.06,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(Icons.dark_mode,
                              color: CustomColors.primaryWhiteColor),
                        ),
                        CustomSizedBoxWidth(),
                        Text(
                          LocaleKeys.change_app_mode.tr(),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                    Switch(
                      activeColor: Colors.red,
                      value: AppCubit.get(context).isDark,
                      onChanged: (value) {
                        AppCubit.get(context).changeAppMode();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: size.width * 0.06,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(Icons.privacy_tip,
                          color: CustomColors.primaryWhiteColor),
                    ),
                    CustomSizedBoxWidth(),
                    Text(
                      LocaleKeys.privacy_policy.tr(),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(
                      width: size.width * 0.15,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
