import 'package:blood_donation/Screens/settings/profile/edit_profile_screen.dart';
import 'package:blood_donation/shared/functions.dart';
import 'package:blood_donation/usable_widgets/custom_sized_box_height.dart';
import 'package:flutter/material.dart';

import '../../../Styles/custom_colors.dart';
import '../../../shared/constants.dart';
import '../../../shared/strings.dart';
import '../../../usable_widgets/custom_divider.dart';
import '../../../usable_widgets/loading.dart';
import 'profile_card_item.dart';

class ProfileBodyWidget extends StatelessWidget {
  const ProfileBodyWidget({
    Key? key,
    required this.userData,
  }) : super(key: key);

  final dynamic userData;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return userData != null
        ? SafeArea(
            child: Container(
              padding: Constants.primaryPadding,
              child: Column(
                children: [
                  SizedBox(
                    width: width * 0.25,
                    height: width * 0.25,
                    child: Stack(
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: double.infinity,
                            child: Icon(
                              Icons.account_circle,
                              size: height * 0.1,
                              color: CustomColors.primaryRedColor,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () {
                              Functions.navigatorPush(
                                context: context,
                                screen: EditProfileScreen(userData: userData),
                              );
                            },
                            child: const Icon(
                              Icons.edit,
                              color: CustomColors.primaryRedColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const CustomSizedBoxHeight(),
                  const CustomSizedBoxHeight(),
                  const CustomSizedBoxHeight(),
                  ProfileCardItem(
                    icon: Icons.person,
                    subTitle: userData[Strings.userName],
                  ),
                  const CustomDivider(),
                  ProfileCardItem(
                    icon: Icons.cake,
                    subTitle: userData[Strings.userDateofBirth],
                  ),
                  const CustomDivider(),
                  ProfileCardItem(
                    icon: Icons.location_on,
                    subTitle: userData[Strings.userAddress],
                  ),
                  const CustomDivider(),
                  ProfileCardItem(
                    icon: Icons.phone,
                    subTitle: userData[Strings.userPhone],
                  ),
                  const CustomDivider(),
                  ProfileCardItem(
                    icon: Icons.mail,
                    subTitle: userData[Strings.userEmail],
                  ),
                  const CustomDivider(),
                  ProfileCardItem(
                    icon: Icons.bloodtype,
                    subTitle: userData[Strings.userBloodType],
                  ),
                ],
              ),
            ),
          )
        : const Loading();
  }
}
