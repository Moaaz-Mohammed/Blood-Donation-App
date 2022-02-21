import 'package:blood_donation/Screens/home/new_home_screen.dart';
import 'package:blood_donation/Styles/custom_colors.dart';
import 'package:blood_donation/usable_widgets/custom_button.dart';
import 'package:blood_donation/usable_widgets/custom_sized_box_width.dart';
import 'package:blood_donation/shared/constants.dart';
import 'package:blood_donation/shared/controllers.dart';
import 'package:blood_donation/shared/functions.dart';
import 'package:blood_donation/state_management/bloc/cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../shared/strings.dart';
import '../../../../translations/locale_keys.g.dart';

class Patient extends StatefulWidget {
  const Patient({Key? key}) : super(key: key);

  @override
  _PatientState createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  String? bloodType;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.register_new_patient.tr()),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        //Name
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.required.tr();
                            }
                            return null;
                          },
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.patient_name.tr(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        // Status
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.required.tr();
                            }
                            return null;
                          },
                          controller: statusController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.status_of_patient.tr(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //Phone number
                        TextFormField(
                          cursorColor: CustomColors.primaryRedColor,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.required.tr();
                            }
                            return null;
                          },
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.phone.tr(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //another phone number
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.required.tr();
                            }
                            return null;
                          },
                          controller: anotherphoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.another_phone.tr(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //Blood type
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
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(
                                      color: CustomColors.primaryRedColor,
                                    ),
                              ),
                              const CustomSizedBoxWidth(),
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
                                              color:
                                                  CustomColors.primaryDarkColor,
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
                                              color:
                                                  CustomColors.primaryDarkColor,
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
                                              color:
                                                  CustomColors.primaryDarkColor,
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
                                              color:
                                                  CustomColors.primaryDarkColor,
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
                                              color:
                                                  CustomColors.primaryDarkColor,
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
                                              color:
                                                  CustomColors.primaryDarkColor,
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
                                              color:
                                                  CustomColors.primaryDarkColor,
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
                                              color:
                                                  CustomColors.primaryDarkColor,
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
                        const SizedBox(
                          height: 10,
                        ),
                        AppCubit.get(context).isDark
                            ? const Divider(
                                thickness: 1,
                              )
                            : const SizedBox(),
                        // Age
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.required.tr();
                            }
                            return null;
                          },
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.age.tr(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //hospital address
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.required.tr();
                            }
                            return null;
                          },
                          controller: hospitalController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.hospital.tr(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //blood amount needed
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.required.tr();
                            }
                            return null;
                          },
                          controller: bloodamountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.needed_blood.tr(),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 40,
                ),
                //Submit Button
                CustomButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      final firestoreInstance = FirebaseFirestore.instance;
                      firestoreInstance
                          .collection(Strings.patientsCollection)
                          .add({
                        Strings.patientName: nameController.text,
                        Strings.patientStatus: statusController.text,
                        Strings.patientPhone: phoneController.text,
                        Strings.patientAnotherPhone:
                            anotherphoneController.text,
                        Strings.patientBloodType: bloodType.toString(),
                        Strings.patientAge: ageController.text,
                        Strings.patientAddress: hospitalController.text,
                        Strings.patientNeededBlood: bloodamountController.text,
                        Strings.patientRegisteredTime: DateTime.now().toLocal(),
                      }).then(
                        (value) => Functions.showToastMsg(
                          title: LocaleKeys.sent.tr(),
                        ).then(
                          (value) => Functions.navigatorPush(
                            context: context,
                            screen: const NewHomeScreen(),
                          ),
                        ),
                      );
                    }
                  },
                  title: LocaleKeys.submit.tr(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
