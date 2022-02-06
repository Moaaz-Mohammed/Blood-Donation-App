import 'package:blood_donation/Screens/auth/log_in_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../UsableWidgets/custom_sized_box_height.dart';
import '../../UsableWidgets/custom_sized_box_width.dart';
import '../../shared/Constants.dart';
import '../../shared/Functions.dart';
import '../../translations/locale_keys.g.dart';

class ChooseLanguageScreen extends StatelessWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.choose_app_language.tr(),
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () async {
              await context.setLocale(Locale('en', 'US')).then(
                (value) {
                  Functions.navigatorPushAndRemove(
                    context: context,
                    screen: LogInScreen(),
                  );
                },
              );
            },
            child: Column(
              children: [
                Image.asset(
                  Constants.ukFlag,
                  width: 100,
                  height: 100,
                ),
                CustomSizedBoxWidth(),
                Text(
                  'English - UK',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ),
          CustomSizedBoxHeight(),
          InkWell(
            onTap: () async {
              await context.setLocale(Locale('ar', 'EG')).then(
                (value) {
                  Functions.navigatorPushAndRemove(
                    context: context,
                    screen: LogInScreen(),
                  );
                },
              );
            },
            child: Column(
              children: [
                Image.asset(
                  Constants.egFlag,
                  width: 100,
                  height: 100,
                ),
                CustomSizedBoxWidth(),
                Text(
                  'العربية - EG',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
