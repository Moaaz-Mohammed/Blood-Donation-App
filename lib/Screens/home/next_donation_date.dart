import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../Styles/CustomColors.dart';
import '../../Styles/Strings.dart';
import '../../shared/constants.dart';
import '../../translations/locale_keys.g.dart';

class NextDonationDate extends StatelessWidget {
  const NextDonationDate({
    Key? key,
    required this.userData,
  }) : super(key: key);
  final userData;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Constants.primaryPadding,
      width: double.infinity,
      decoration: BoxDecoration(
        color: CustomColors.primaryRedColor,
        borderRadius: Constants.primaryBorderRadius,
      ),
      child: Padding(
        padding: Constants.primaryPadding,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData![Strings.userLastDonation] ??
                            LocaleKeys.no_data.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: CustomColors.primaryWhiteColor),
                      ),
                    ],
                  ),
                ),
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.map),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
