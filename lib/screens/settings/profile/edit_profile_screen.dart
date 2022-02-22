import 'package:blood_donation/state_management/bloc/cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../Styles/custom_colors.dart';
import '../../../services/store.dart';
import '../../../shared/constants.dart';
import '../../../shared/functions.dart';
import '../../../shared/strings.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../usable_widgets/custom_button.dart';
import '../../../usable_widgets/custom_sized_box_height.dart';
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
  TextEditingController userBirthDateController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userAddressController = TextEditingController();
  TextEditingController userBloodTypeController = TextEditingController();
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
    userBirthDateController.text = widget.userData[Strings.userDateofBirth];
    userPhoneController.text = widget.userData[Strings.userPhone];
    userAddressController.text = widget.userData[Strings.userAddress];
    userBloodTypeController.text = widget.userData[Strings.userBloodType];
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
                    color: CustomColors.primaryRedColor.withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: AppCubit.get(context).isDark
                      ? CustomColors.primaryDarkColor
                      : CustomColors.primaryWhiteColor,
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
                style: Theme.of(context).textTheme.headline2?.copyWith(
                    color: AppCubit.get(context).isDark
                        ? CustomColors.primaryGreyColor
                        : CustomColors.primaryRedColor),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  hintText: LocaleKeys.name.tr(),
                  hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                        color: AppCubit.get(context).isDark
                            ? CustomColors.primaryGreyColor
                            : CustomColors.primaryRedColor,
                      ),
                ),
                controller: userNameController,
              ),
              const CustomSizedBoxHeight(),
              TextFormField(
                style: Theme.of(context).textTheme.headline2?.copyWith(
                    color: AppCubit.get(context).isDark
                        ? CustomColors.primaryGreyColor
                        : CustomColors.primaryRedColor),
                controller: userBirthDateController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.date_range),
                  hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                      color: AppCubit.get(context).isDark
                          ? CustomColors.primaryGreyColor
                          : CustomColors.primaryRedColor),
                  hintText: LocaleKeys.date_of_birth.tr(),
                ),
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          lastDate: DateTime(2050),
                          firstDate: DateTime(1900))
                      .then((value) {
                    userBirthDateController.text =
                        DateFormat.yMd().format(value!);
                  });
                },
                validator: (value) {
                  value == null ? LocaleKeys.required.tr() : null;
                  return null;
                },
              ),
              const CustomSizedBoxHeight(),
              TextFormField(
                style: Theme.of(context).textTheme.headline2?.copyWith(
                    color: AppCubit.get(context).isDark
                        ? CustomColors.primaryGreyColor
                        : CustomColors.primaryRedColor),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.phone),
                  hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                      color: AppCubit.get(context).isDark
                          ? CustomColors.primaryGreyColor
                          : CustomColors.primaryRedColor),
                  hintText: LocaleKeys.phone.tr(),
                ),
                controller: userPhoneController,
                keyboardType: TextInputType.number,
              ),
              const CustomSizedBoxHeight(),
              TextFormField(
                style: Theme.of(context).textTheme.headline2?.copyWith(
                    color: AppCubit.get(context).isDark
                        ? CustomColors.primaryGreyColor
                        : CustomColors.primaryRedColor),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.location_on),
                  hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                      color: AppCubit.get(context).isDark
                          ? CustomColors.primaryGreyColor
                          : CustomColors.primaryRedColor),
                  hintText: LocaleKeys.address.tr(),
                ),
                controller: userAddressController,
              ),
              const CustomSizedBoxHeight(),
              TextFormField(
                style: Theme.of(context).textTheme.headline2?.copyWith(
                    color: AppCubit.get(context).isDark
                        ? CustomColors.primaryGreyColor
                        : CustomColors.primaryRedColor),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.bloodtype),
                  hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                      color: AppCubit.get(context).isDark
                          ? CustomColors.primaryGreyColor
                          : CustomColors.primaryRedColor),
                  hintText: LocaleKeys.phone.tr(),
                ),
                controller: userBloodTypeController,
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
                        userBirthDateController.text ==
                            widget.userData[Strings.userDateofBirth] &&
                        userBloodTypeController.text ==
                            widget.userData[Strings.userBloodType] &&
                        userAddressController.text ==
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
                        userLocation: userAddressController.text,
                        userDateofBirth: userBirthDateController.text,
                        userPhone: userPhoneController.text,
                      );
                    }
                  } else {
                    _store.editUserProfile(
                      context: context,
                      userPhone: userPhoneController.text,
                      userId: widget.userData[Strings.userId],
                      userName: userNameController.text,
                      userLocation: userAddressController.text,
                      userDateofBirth: userBirthDateController.text,
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
