import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../Styles/CustomColors.dart';
import '../../../UsableWidgets/custom_button.dart';
import '../../../UsableWidgets/custom_sized_box_height.dart';
import '../../../services/store.dart';
import '../../../shared/Functions.dart';
import '../../../shared/Strings.dart';
import '../../../shared/constants.dart';
import '../../../translations/locale_keys.g.dart';
import '../../home/new_home_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    Key? key,
    required this.userData,
  }) : super(key: key);
  final dynamic userData;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userAgeController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userLocationController = TextEditingController();
  String? userImageUrl;

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data();
  }

  void data() {
    userNameController.text = widget.userData[Strings.userName];
    userAgeController.text = widget.userData[Strings.userDateofBirth];
    userPhoneController.text = widget.userData[Strings.userPhone];
    userLocationController.text = widget.userData[Strings.userAddress];
  }

  final Store _store = Store();
  dynamic _image;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.edit_profile.tr(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: Constants.primaryPadding,
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              const CustomSizedBoxHeight(),
              Container(
                width: width * 0.30,
                height: width * 0.30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: CustomColors.primaryRedColor,
                    width: 2,
                  ),
                ),
                child: const CircleAvatar(
                  backgroundColor: CustomColors.primaryWhiteColor,
                  radius: double.infinity,
                  child: Icon(
                    Icons.account_circle,
                    size: 100,
                    color: CustomColors.primaryRedColor,
                  ),
                ),
              ),
              const CustomSizedBoxHeight(),
              const CustomSizedBoxHeight(),
              TextFormField(
                decoration: InputDecoration(
                  hintText: LocaleKeys.name.tr(),
                ),
                controller: userNameController,
              ),
              const CustomSizedBoxHeight(),
              TextFormField(
                decoration: InputDecoration(
                  hintText: LocaleKeys.date_of_birth.tr(),
                ),
                controller: userAgeController,
                keyboardType: TextInputType.number,
              ),
              const CustomSizedBoxHeight(),
              TextFormField(
                decoration: InputDecoration(
                  hintText: LocaleKeys.phone.tr(),
                ),
                controller: userPhoneController,
                keyboardType: TextInputType.number,
              ),
              const CustomSizedBoxHeight(),
              TextFormField(
                decoration: InputDecoration(
                  hintText: LocaleKeys.address.tr(),
                ),
                controller: userLocationController,
              ),
              const CustomSizedBoxHeight(),
              const CustomSizedBoxHeight(),
              CustomButton(
                title: LocaleKeys.save_changes.tr(),
                onTap: () async {
                  if (_globalKey.currentState!.validate()) {
                    if (userNameController.text ==
                            widget.userData[Strings.userName] &&
                        userPhoneController.text ==
                            widget.userData[Strings.userPhone] &&
                        userAgeController.text ==
                            widget.userData[Strings.userDateofBirth] &&
                        userLocationController.text ==
                            widget.userData[Strings.userAddress] &&
                        _image == null) {
                      Functions.navigatorPushAndRemove(
                        context: context,
                        screen: const NewHomeScreen(),
                      );
                    } else {
                      Functions.dialogLoading(
                        context: context,
                        title: LocaleKeys.saving_changes.tr(),
                      );

                      _store.editUserProfile(
                        context: context,
                        userId: widget.userData[Strings.userId],
                        userName: userNameController.text,
                        userLocation: userLocationController.text,
                        userDateofBirth: userAgeController.text,
                        userPhone: userPhoneController.text,
                      );
                    }
                  } else {
                    _store.editUserProfile(
                      context: context,
                      userPhone: userPhoneController.text,
                      userId: widget.userData[Strings.userId],
                      userName: userNameController.text,
                      userLocation: userLocationController.text,
                      userDateofBirth: userAgeController.text,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
