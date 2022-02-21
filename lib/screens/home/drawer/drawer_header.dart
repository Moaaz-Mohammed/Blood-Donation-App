import 'package:blood_donation/Screens/settings/profile/profile_screen.dart';
import 'package:blood_donation/shared/functions.dart';
import 'package:flutter/material.dart';

import '../../../Styles/custom_colors.dart';
import '../../../shared/strings.dart';

class DrawerHead extends StatelessWidget {
  const DrawerHead({
    Key? key,
    required this.userData,
  }) : super(key: key);
  final dynamic userData;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: InkWell(
        onTap: () {
          Functions.navigatorPush(
            context: context,
            screen: ProfileScreen(userData: userData),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.account_circle,
              size: 75,
              color: CustomColors.primaryRedColor,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              userData[Strings.userName],
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
