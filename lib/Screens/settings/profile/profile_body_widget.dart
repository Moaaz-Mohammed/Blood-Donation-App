import 'package:blood_donation/Screens/settings/profile/profile_card_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../Styles/CustomColors.dart';
import '../../../UsableWidgets/custom_button.dart';
import '../../../UsableWidgets/custom_sized_box_height.dart';
import '../../../UsableWidgets/custom_sized_box_width.dart';
import '../../../UsableWidgets/loading.dart';
import '../../../services/auth.dart';
import '../../../shared/Constants.dart';
import '../../../shared/Functions.dart';
import '../../../translations/locale_keys.g.dart';
import 'edit_profile_screen.dart';

class ProfileBodyWidget extends StatelessWidget {
  const ProfileBodyWidget({
    Key? key,
    required this.userData,
  });

  final userData;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return userData != null
        ?  ListView(
              padding: Constants.primaryPadding,
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  padding: Constants.primaryPadding,
                  child: Center(
                    child: Container(
                      width: width * 0.5,
                      height: width * 0.5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: CustomColors.primaryRedColor,
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          Functions.dialogOpenPhotoAndZoom(
                            context: context,
                            image: userData[Constants.userImageUrl],
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor:
                          CustomColors.primaryRedColor.withOpacity(0.1),
                          radius: 50.0,
                          backgroundImage:
                              userData[Constants.userImageUrl] == null
                                  ? AssetImage(
                                      Constants.addUserImage,
                                    ) as ImageProvider
                                  : NetworkImage(
                                      userData[Constants.userImageUrl],
                                    ),
                        ),
                      ),
                    ),
                  ),
                ),
                CustomSizedBoxHeight(),
                Container(
                  padding: Constants.primaryPadding,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          title: LocaleKeys.edit_profile.tr(),
                          height: 45.0,
                          backgroundColor: Theme.of(context).textTheme.headline1?.color,
                          borderColor: CustomColors.primaryDarkColor,
                          onTap: () {
                            Functions.dialogDoYouWant(
                              context: context,
                              title: LocaleKeys.ask_for_edit_profile.tr(),
                              onTapYes: () {
                                Navigator.pop(context);
                                Functions.navigatorPush(
                                  context: context,
                                  screen: EditProfileScreen(
                                    userData: userData,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      CustomSizedBoxWidth(),
                      Expanded(
                        child: CustomButton(
                          title: LocaleKeys.logout.tr(),
                          height: 45.0,
                          onTap: () {
                            Functions.dialogDoYouWant(
                              context: context,
                              title: LocaleKeys.ask_for_logout.tr(),
                              onTapYes: () {
                                Auth auth = Auth();
                                auth.signOut(context: context);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                CustomSizedBoxHeight(),
                Container(
                  padding: Constants.primaryPadding,
                  child: Column(
                    children: [
                      ProfileCardItem(
                        title: LocaleKeys.name.tr(),
                        subTitle: userData[Constants.userName],
                      ),
                      Divider(
                        indent: 10.0,
                        endIndent: 10.0,
                      ),
                      ProfileCardItem(
                        title: LocaleKeys.age.tr(),
                        subTitle: userData[Constants.userDateofBirth],
                      ),
                      Divider(
                        indent: 10.0,
                        endIndent: 10.0,
                      ),
                      ProfileCardItem(
                        title: LocaleKeys.address.tr(),
                        subTitle: userData[Constants.userAddress],
                      ),
                      Divider(
                        indent: 10.0,
                        endIndent: 10.0,
                      ),
                      ProfileCardItem(
                        title: LocaleKeys.phone.tr(),
                        subTitle: userData[Constants.userPhone],
                      ),
                      Divider(
                        indent: 10.0,
                        endIndent: 10.0,
                      ),
                      ProfileCardItem(
                        title: LocaleKeys.email.tr(),
                        subTitle: userData[Constants.userEmail],
                      ),
                    ],
                  ),
                ),
              ],
            )
        : Loading();
  }
}
