import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../Styles/CustomColors.dart';
import '../Styles/Images.dart';
import 'custom_sized_box_height.dart';
import 'custom_sized_box_width.dart';

void change_language_dialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  InkWell(
                    child: const Icon(
                      Icons.close,
                      color: CustomColors.primaryRedColor,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(),
                ],
              )),
          InkWell(
            onTap: () async {
              await context.setLocale(const Locale('en', 'US')).then((value) {
                Navigator.pop(context);
              });
            },
            child: Row(
              children: [
                Image.asset(
                  Images.ukFlag,
                  width: 30,
                  height: 30,
                ),
                CustomSizedBoxWidth(),
                Text(
                  'English - UK',
                  style: Theme.of(context).textTheme.headline2,
                )
              ],
            ),
          ),
          CustomSizedBoxHeight(),
          InkWell(
            onTap: () async {
              await context.setLocale(const Locale('ar', 'EG')).then((value) {
                Navigator.pop(context);
              });
            },
            child: Row(
              children: [
                Image.asset(
                  Images.egFlag,
                  width: 30,
                  height: 30,
                ),
                CustomSizedBoxWidth(),
                Text(
                  'العربية - EG',
                  style: Theme.of(context).textTheme.headline2,
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
