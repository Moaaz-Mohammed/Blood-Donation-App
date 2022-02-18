import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../shared/constants.dart';
import '../translations/locale_keys.g.dart';
import 'custom_button.dart';
import 'custom_sized_box_width.dart';

class CustomDialogDoYouWant extends StatelessWidget {
  const CustomDialogDoYouWant({
    Key? key,
    required this.onTapYes,
    required this.title,
  }) : super(key: key);

  final onTapYes;
  final title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: Constants.primaryBorderRadius,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      content: Row(
        children: [
          Expanded(
            child: CustomButton(
              height: 40.0,
              title: LocaleKeys.yes.tr(),
              onTap: () {
                onTapYes();
              },
              backgroundColor: Colors.green,
              borderColor: Colors.green,
            ),
          ),
          const CustomSizedBoxWidth(),
          Expanded(
            child: CustomButton(
              height: 40.0,
              title: LocaleKeys.no.tr(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
