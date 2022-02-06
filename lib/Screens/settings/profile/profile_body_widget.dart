import 'package:blood_donation/Screens/settings/profile/profile_card_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../Styles/CustomColors.dart';
import '../../../UsableWidgets/custom_sized_box_height.dart';
import '../../../UsableWidgets/loading.dart';
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
        ? ListView(
            padding: Constants.primaryPadding,
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                padding: Constants.primaryPadding,
                child: Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: width * 0.35,
                        height: width * 0.35,
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
                                    ? const AssetImage(
                                        Constants.addUserImage,
                                      ) as ImageProvider
                                    : NetworkImage(
                                        userData[Constants.userImageUrl],
                                      ),
                          ),
                        ),
                      ),
                      InkWell(
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
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: CustomColors.primaryWhiteColor,
                          child: Icon(
                            Icons.edit,
                            color: CustomColors.primaryRedColor,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                      title: LocaleKeys.date_of_birth.tr(),
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
                    Divider(
                      indent: 10.0,
                      endIndent: 10.0,
                    ),
                    ProfileCardItem(
                      title: LocaleKeys.blood_type.tr(),
                      subTitle: userData[Constants.userBloodType],
                    ),
                  ],
                ),
              ),
            ],
          )
        : const Loading();
  }
}
