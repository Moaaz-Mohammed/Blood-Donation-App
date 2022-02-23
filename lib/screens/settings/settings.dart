import 'package:blood_donation/Screens/settings/profile/profile_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../Styles/custom_colors.dart';
import '../../shared/functions.dart';
import '../../shared/strings.dart';
import '../../state_management/bloc/cubit.dart';
import '../../translations/locale_keys.g.dart';
import '../../usable_widgets/arrow_box.dart';
import '../../usable_widgets/change_language_dialog.dart';
import '../../usable_widgets/custom_sized_box_width.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    Key? key,
    required this.userData,
  }) : super(key: key);
  final dynamic userData;

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
            padding: const EdgeInsets.all(20),
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
                  title: Text(
                    userData[Strings.userName],
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
                      child: const Icon(Icons.language,
                          color: CustomColors.primaryWhiteColor),
                    ),
                    const CustomSizedBoxWidth(),
                    InkWell(
                      onTap: () {
                        changeLanguageDialog(context);
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
                          child: const Icon(Icons.dark_mode,
                              color: CustomColors.primaryWhiteColor),
                        ),
                        const CustomSizedBoxWidth(),
                        Text(
                          LocaleKeys.change_app_mode.tr(),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                    FlutterSwitch(
                        activeColor: CustomColors.primaryGreyColor,
                        inactiveColor: CustomColors.primaryRedColor,
                        inactiveIcon: const Icon(
                          Icons.light_mode,
                          color: Colors.amber,
                        ),
                        activeToggleColor: Colors.grey,
                        activeIcon: const Icon(
                          Icons.dark_mode,
                          color: CustomColors.primaryWhiteColor,
                        ),
                        value: AppCubit.get(context).isDark,
                        onToggle: (value) {
                          AppCubit.get(context).changeAppMode();
                        }),
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
                      child: const Icon(Icons.privacy_tip,
                          color: CustomColors.primaryWhiteColor),
                    ),
                    const CustomSizedBoxWidth(),
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
