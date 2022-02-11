import 'package:blood_donation/shared/Controllers.dart';
import 'package:blood_donation/shared/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../Styles/CustomColors.dart';
import '../UsableWidgets/custom_button.dart';
import '../translations/locale_keys.g.dart';
import 'home/new_home_screen.dart';

class Patient extends StatefulWidget {
  const Patient({Key? key}) : super(key: key);

  @override
  _PatientState createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  var BloodType;
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
                        SizedBox(
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
                        SizedBox(
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
                        SizedBox(
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
                        SizedBox(
                          height: 10,
                        ),
                        //Blood type
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            children: [
                              DropdownButton(
                                dropdownColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                alignment: Alignment.center,
                                iconSize: 30,
                                iconEnabledColor: CustomColors.primaryRedColor,
                                value: BloodType,
                                hint: Text(
                                  LocaleKeys.choose_blood_type.tr(),
                                  style: TextStyle(color: Colors.grey),
                                ),
                                items: [
                                  DropdownMenuItem(
                                    child:
                                        Center(child: defaultText(text: '+O')),
                                    value: '+O',
                                  ),
                                  DropdownMenuItem(
                                    child:
                                        Center(child: defaultText(text: '-O')),
                                    value: '-O',
                                  ),
                                  DropdownMenuItem(
                                    child:
                                        Center(child: defaultText(text: '+A')),
                                    value: '+A',
                                  ),
                                  DropdownMenuItem(
                                    child:
                                        Center(child: defaultText(text: '-A')),
                                    value: '-A',
                                  ),
                                  DropdownMenuItem(
                                    child:
                                        Center(child: defaultText(text: '+B')),
                                    value: '+B',
                                  ),
                                  DropdownMenuItem(
                                    child:
                                        Center(child: defaultText(text: '-B')),
                                    value: '-B',
                                  ),
                                  DropdownMenuItem(
                                    child:
                                        Center(child: defaultText(text: '+AB')),
                                    value: '+AB',
                                  ),
                                  DropdownMenuItem(
                                    child:
                                        Center(child: defaultText(text: '-AB')),
                                    value: '-AB',
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    BloodType = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
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
                        SizedBox(
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
                        SizedBox(
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
                SizedBox(
                  height: 40,
                ),
                //Submit Button
                CustomButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      final firestoreInstance = FirebaseFirestore.instance;
                      firestoreInstance.collection("Patient").add({
                        "name": nameController.text,
                        "status": statusController.text,
                        "phone": phoneController.text,
                        "another_phone": anotherphoneController.text,
                        "blood_type": BloodType.toString(),
                        "age": ageController.text,
                        "hospital": hospitalController.text,
                        "blood_needed": bloodamountController.text,
                        "registered_time": DateTime.now().toLocal(),
                      }).then(
                        (value) => showDialog(
                          context: context,
                          builder: (context) => CustomDialog(
                            image: Image.network(
                                'https://media.tenor.com/images/2525ba72ea472c55bf8b2153e9ea9f11/tenor.gif'),
                            title: LocaleKeys.sent.tr(),
                            description1: LocaleKeys.sent.tr(),
                          ),
                        ).then((value) => navigateTo(context, NewHomeScreen())),
                      );
                    }
                    ;
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
