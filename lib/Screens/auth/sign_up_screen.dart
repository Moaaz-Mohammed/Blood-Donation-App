import 'package:blood_donation/UsableWidgets/custom_sized_box_height.dart';
import 'package:blood_donation/UsableWidgets/custom_sized_box_width.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../Styles/CustomColors.dart';
import '../../UsableWidgets/custom_button.dart';
import '../../model/user_model.dart';
import '../../services/auth.dart';
import '../../services/store.dart';
import '../../shared/Functions.dart';
import '../../shared/constants.dart';
import '../../state_management/bloc/Cubit.dart';
import '../../state_management/provider/model_hud.dart';
import '../../translations/locale_keys.g.dart';
import '../home/new_home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final Auth _auth = Auth();
  final Store _store = Store();
  String? bloodType;
  String? Status;
  String? ShareData;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userLocationController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController userBirthDateController = TextEditingController();
  TextEditingController userLastDonationDateController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: Provider.of<ModelHud>(context).isLoading1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.register.tr()),
        ),
        body: Form(
          key: _globalKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: Constants.primaryPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                TextFormField(
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: CustomColors.primaryDarkColor,
                      ),
                  decoration: InputDecoration(
                    labelText: LocaleKeys.name.tr(),
                  ),
                  controller: userNameController,
                  keyboardType: TextInputType.text,
                ),
                const CustomSizedBoxHeight(),
                // E-Mail
                TextFormField(
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: CustomColors.primaryDarkColor,
                      ),
                  decoration: InputDecoration(
                    labelText: LocaleKeys.email.tr(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: userEmailController,
                ),
                const CustomSizedBoxHeight(),
                // Password
                TextFormField(
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: CustomColors.primaryDarkColor,
                      ),
                  decoration: InputDecoration(
                    labelText: LocaleKeys.password.tr(),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          AppCubit.get(context).isVisible =
                              !AppCubit.get(context).isVisible;
                        });
                      },
                      child: Icon(AppCubit.get(context).isVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  controller: userPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: AppCubit.get(context).isVisible,
                ),
                const CustomSizedBoxHeight(),
                // Do You Suffer any Diseases?
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: AppCubit.get(context).isDark
                      ? const BoxDecoration(
                          color: CustomColors.primaryDarkColor)
                      : Constants.primaryBoxDecorationContainer,
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.do_u_suffer.tr(),
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                              color: CustomColors.primaryRedColor,
                            ),
                      ),
                      DropdownButton(
                        alignment: Alignment.center,
                        dropdownColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        iconSize: 25,
                        iconEnabledColor: CustomColors.primaryDarkColor,
                        value: Status,
                        hint: Text(
                          LocaleKeys.choose.tr(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        items: [
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                LocaleKeys.no_chronic_diseases.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryDarkColor,
                                    ),
                              ),
                            ),
                            value: LocaleKeys.no_chronic_diseases.tr(),
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                LocaleKeys.anemia_diseases.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryDarkColor,
                                    ),
                              ),
                            ),
                            value: LocaleKeys.anemia_diseases.tr(),
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                LocaleKeys.genetic_blood_diseases.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryDarkColor,
                                    ),
                              ),
                            ),
                            value: LocaleKeys.genetic_blood_diseases.tr(),
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                LocaleKeys.hepatitis.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryDarkColor,
                                    ),
                              ),
                            ),
                            value: LocaleKeys.hepatitis.tr(),
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                LocaleKeys.aids.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryDarkColor,
                                    ),
                              ),
                            ),
                            value: LocaleKeys.aids.tr(),
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                LocaleKeys.cancer.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryDarkColor,
                                    ),
                              ),
                            ),
                            value: LocaleKeys.cancer.tr(),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            Status = value as String?;
                          });
                        },
                      )
                    ],
                  ),
                ),
                const CustomSizedBoxHeight(),
                const Divider(
                  thickness: 0.85,
                ),
                // Blood Types
                Container(
                  height: 80,
                  decoration: AppCubit.get(context).isDark
                      ? const BoxDecoration(
                          color: CustomColors.primaryDarkColor)
                      : Constants.primaryBoxDecorationContainer,
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Row(
                    children: [
                      Text(
                        LocaleKeys.blood_types.tr(),
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                              color: CustomColors.primaryRedColor,
                            ),
                      ),
                      SizedBox(width: width * 0.15),
                      DropdownButton(
                        dropdownColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        alignment: Alignment.center,
                        iconSize: 30,
                        iconEnabledColor: CustomColors.primaryDarkColor,
                        value: bloodType,
                        hint: Text(
                          LocaleKeys.choose_blood_type.tr(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        items: [
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                "+O",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryDarkColor,
                                    ),
                              ),
                            ),
                            value: '+O',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                '-O',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryDarkColor,
                                    ),
                              ),
                            ),
                            value: '-O',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                "+A",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryDarkColor,
                                    ),
                              ),
                            ),
                            value: '+A',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                "-A",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryDarkColor,
                                    ),
                              ),
                            ),
                            value: '-A',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                "+B",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryDarkColor,
                                    ),
                              ),
                            ),
                            value: '+B',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                "-B",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryDarkColor,
                                    ),
                              ),
                            ),
                            value: '-B',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                "+AB",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryDarkColor,
                                    ),
                              ),
                            ),
                            value: '+AB',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                "-AB",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryDarkColor,
                                    ),
                              ),
                            ),
                            value: '-AB',
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            bloodType = value as String?;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 0.85,
                ),
                const CustomSizedBoxHeight(),
                // Phone
                TextFormField(
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: CustomColors.primaryDarkColor,
                      ),
                  decoration: InputDecoration(
                    labelText: LocaleKeys.phone.tr(),
                  ),
                  keyboardType: TextInputType.number,
                  controller: userPhoneController,
                ),
                const CustomSizedBoxHeight(),
                // Date of Birth
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: AppCubit.get(context).isDark
                      ? const BoxDecoration(
                          color: CustomColors.primaryDarkColor)
                      : Constants.primaryBoxDecorationContainer,
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.date_of_birth.tr(),
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                              color: CustomColors.primaryRedColor,
                            ),
                      ),
                      const CustomSizedBoxWidth(),
                      TextFormField(
                        style: Theme.of(context).textTheme.headline2,
                        controller: userBirthDateController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.date_range),
                          hintStyle: Theme.of(context).textTheme.headline2,
                          hintText: LocaleKeys.date_of_birth.tr(),
                        ),
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  lastDate: DateTime(2050),
                                  firstDate: DateTime(2000))
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
                    ],
                  ),
                ),
                const CustomSizedBoxHeight(),
                // Last Donation Date
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: AppCubit.get(context).isDark
                      ? const BoxDecoration(
                          color: CustomColors.primaryDarkColor)
                      : Constants.primaryBoxDecorationContainer,
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.last_donation_date.tr(),
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                              color: CustomColors.primaryRedColor,
                            ),
                      ),
                      const CustomSizedBoxHeight(),
                      TextFormField(
                        style: Theme.of(context).textTheme.headline2,
                        controller: userLastDonationDateController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.date_range),
                          hintStyle: Theme.of(context).textTheme.headline2,
                          hintText: LocaleKeys.last_donation_date.tr(),
                        ),
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  lastDate: DateTime(2050),
                                  firstDate: DateTime(2000))
                              .then((value) {
                            userLastDonationDateController.text =
                                DateFormat.yMd().format(value!);
                          });
                        },
                        validator: (value) {
                          value == null ? LocaleKeys.required.tr() : null;
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const CustomSizedBoxHeight(),
                // Address
                TextFormField(
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: CustomColors.primaryDarkColor,
                      ),
                  decoration: InputDecoration(
                    labelText: LocaleKeys.address.tr(),
                  ),
                  controller: userLocationController,
                ),
                const CustomSizedBoxHeight(),
                CustomButton(
                  title: LocaleKeys.register.tr(),
                  onTap: () async {
                    if (_globalKey.currentState!.validate()) {
                      Functions.dialogLoading(
                        context: context,
                        title: LocaleKeys.registering.tr(),
                      );
                      await _auth
                          .signUpWithEmailAndPassword(
                        userEmailController.text,
                        userPasswordController.text,
                        context,
                      )
                          .then(
                        (value) {
                          User? userAuth = FirebaseAuth.instance.currentUser;
                          _store
                              .addUser(
                            UserModel(
                              userId: userAuth!.uid,
                              userName: userNameController.text,
                              userPhone: userPhoneController.text,
                              userEmail: userEmailController.text,
                              userAddress: userLocationController.text,
                              userDateofBirth: userBirthDateController.text,
                              userLastDonation: userBirthDateController.text,
                              userBloodType: bloodType.toString(),
                              userStatus: Status.toString(),
                            ),
                          )
                              .then(
                            (value) {
                              Functions.navigatorPushAndRemove(
                                context: context,
                                screen: const NewHomeScreen(),
                              );
                              Functions.showToastMsg(
                                title: LocaleKeys.registered.tr(),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
