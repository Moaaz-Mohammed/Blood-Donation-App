import 'package:blood_donation/usable_widgets/custom_sized_box_height.dart';
import 'package:blood_donation/usable_widgets/custom_sized_box_width.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../Styles/custom_colors.dart';
import '../../model/user_model.dart';
import '../../services/auth.dart';
import '../../services/store.dart';
import '../../shared/constants.dart';
import '../../shared/functions.dart';
import '../../state_management/bloc/cubit.dart';
import '../../state_management/provider/model_hud.dart';
import '../../translations/locale_keys.g.dart';
import '../../usable_widgets/custom_button.dart';
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
                  style: Theme.of(context).textTheme.headline2,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.name.tr(),
                  ),
                  controller: userNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                ),
                const CustomSizedBoxHeight(),
                // E-Mail
                TextFormField(
                  style: Theme.of(context).textTheme.headline2,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.email.tr(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: userEmailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
                const CustomSizedBoxHeight(),
                // Password
                TextFormField(
                  style: Theme.of(context).textTheme.headline2,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.password.tr(),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(
                          () {
                            AppCubit.get(context).isVisible =
                                !AppCubit.get(context).isVisible;
                          },
                        );
                      },
                      child: Icon(AppCubit.get(context).isVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  controller: userPasswordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  obscureText: AppCubit.get(context).isVisible,
                ),
                const CustomSizedBoxHeight(),
                // Do You Suffer any Diseases?
                Container(
                  height: 80,
                  width: double.infinity,
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
                        iconEnabledColor: CustomColors.primaryRedColor,
                        value: Status,
                        hint: Text(
                          LocaleKeys.choose.tr(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        borderRadius: Constants.primaryBorderRadius,
                        items: [
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                LocaleKeys.no_chronic_diseases.tr(),
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                            value: LocaleKeys.no_chronic_diseases.tr(),
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                LocaleKeys.anemia_diseases.tr(),
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                            value: LocaleKeys.anemia_diseases.tr(),
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                  LocaleKeys.genetic_blood_diseases.tr(),
                                  style: Theme.of(context).textTheme.headline2),
                            ),
                            value: LocaleKeys.genetic_blood_diseases.tr(),
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(LocaleKeys.hepatitis.tr(),
                                  style: Theme.of(context).textTheme.headline2),
                            ),
                            value: LocaleKeys.hepatitis.tr(),
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(LocaleKeys.aids.tr(),
                                  style: Theme.of(context).textTheme.headline2),
                            ),
                            value: LocaleKeys.aids.tr(),
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(LocaleKeys.cancer.tr(),
                                  style: Theme.of(context).textTheme.headline2),
                            ),
                            value: LocaleKeys.cancer.tr(),
                          ),
                        ],
                        onChanged: (value) {
                          setState(
                            () {
                              Status = value as String?;
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
                const CustomSizedBoxHeight(),
                AppCubit.get(context).isDark
                    ? const SizedBox()
                    : const Divider(
                        thickness: 0.45,
                      ),
                // Blood Types
                Container(
                  height: 80,
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
                        iconEnabledColor: CustomColors.primaryRedColor,
                        value: bloodType,
                        borderRadius: Constants.primaryBorderRadius,
                        hint: Text(
                          LocaleKeys.choose_blood_type.tr(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        items: [
                          DropdownMenuItem(
                            child: Center(
                              child: Text("+O",
                                  style: Theme.of(context).textTheme.headline2),
                            ),
                            value: '+O',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text('-O',
                                  style: Theme.of(context).textTheme.headline2),
                            ),
                            value: '-O',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text("+A",
                                  style: Theme.of(context).textTheme.headline2),
                            ),
                            value: '+A',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text("-A",
                                  style: Theme.of(context).textTheme.headline2),
                            ),
                            value: '-A',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text("+B",
                                  style: Theme.of(context).textTheme.headline2),
                            ),
                            value: '+B',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text("-B",
                                  style: Theme.of(context).textTheme.headline2),
                            ),
                            value: '-B',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text("+AB",
                                  style: Theme.of(context).textTheme.headline2),
                            ),
                            value: '+AB',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text("-AB",
                                  style: Theme.of(context).textTheme.headline2),
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
                AppCubit.get(context).isDark
                    ? const SizedBox()
                    : const Divider(
                        thickness: 0.45,
                      ),
                const CustomSizedBoxHeight(),
                // Phone
                TextFormField(
                  style: Theme.of(context).textTheme.headline2,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.phone.tr(),
                  ),
                  keyboardType: TextInputType.number,
                  controller: userPhoneController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
                const CustomSizedBoxHeight(),
                // Date of Birth
                Container(
                  height: 120,
                  width: double.infinity,
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
                          hintStyle:
                              Theme.of(context).textTheme.headline2?.copyWith(
                                    color: CustomColors.primaryRedColor,
                                  ),
                          hintText: LocaleKeys.date_of_birth.tr(),
                        ),
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  lastDate: DateTime(2050),
                                  firstDate: DateTime(1900))
                              .then(
                            (value) {
                              userBirthDateController.text =
                                  DateFormat.yMd().format(value!);
                            },
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'required';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                AppCubit.get(context).isDark
                    ? const SizedBox()
                    : const Divider(
                        thickness: 0.45,
                      ),
                AppCubit.get(context).isDark
                    ? const SizedBox()
                    : const Divider(
                        thickness: 0.45,
                      ),
                const CustomSizedBoxHeight(),
                // Last Donation Date
                Container(
                  height: 120,
                  width: double.infinity,
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
                          hintStyle:
                              Theme.of(context).textTheme.headline2?.copyWith(
                                    color: CustomColors.primaryRedColor,
                                  ),
                          hintText: LocaleKeys.last_donation_date.tr(),
                        ),
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  lastDate: DateTime(2050),
                                  firstDate: DateTime(2000))
                              .then(
                            (value) {
                              userLastDonationDateController.text =
                                  DateFormat.yMd().format(value!);
                            },
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'required';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const CustomSizedBoxHeight(),
                // Address
                TextFormField(
                  style: Theme.of(context).textTheme.headline2,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.address.tr(),
                  ),
                  controller: userLocationController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
                const CustomSizedBoxHeight(),
                CustomButton(
                  title: LocaleKeys.register.tr(),
                  onTap: () async {
                    if (_globalKey.currentState!.validate()) {
                      if (Status==null || ShareData==null ){
                        Functions.showToastMsg(title: 'please complete data',);
                      } else {
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
                                userLastDonation:
                                userLastDonationDateController.text,
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
