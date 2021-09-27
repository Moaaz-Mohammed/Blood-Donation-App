import 'package:blood_donation/shared/Constants.dart';
import 'package:blood_donation/shared/Controllers.dart';
import 'package:blood_donation/shared/Cubit/Cubit.dart';
import 'package:blood_donation/shared/Cubit/States.dart';
import 'package:blood_donation/shared/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blood_donation/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Home.dart';

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
    return BlocProvider(
      create: (context)=>AppCubit(),
      child: BlocBuilder<AppCubit,AppStates>(
        builder:(context,state){
         return MaterialApp(
           themeMode: ThemeMode.system,
            theme:lighttheme,
            darkTheme: darktheme,
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: SafeArea(
                  child: Scaffold(
                    appBar: AppBar(
                      title: TitleText(text: 'تسجيل بيانات مريض'),
                      centerTitle: true,
                      leading: const Text(''),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Constants.redColor,
                          ),
                        ),
                      ],
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
                                            return 'برجاء إدخال إسم المريض';
                                          }
                                          return null;
                                        },
                                        cursorColor: Constants.redColor,
                                        controller: nameController,
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(color: Constants.redColor),
                                        decoration: InputDecoration(
                                          hintTextDirection: TextDirection.rtl,
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide:
                                              BorderSide(color: Colors.black)),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.black),
                                          ),
                                          labelText: 'اســم المريــض',
                                          labelStyle: TextStyle(color: Colors.grey),
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: Constants.redColor,
                                          ),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),

                                      // Status
                                      TextFormField(
                                        cursorColor: Constants.redColor,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'برجاء وصف حالة المريض';
                                          }
                                          return null;
                                        },
                                        controller: statusController,
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(color: Constants.redColor),
                                        decoration: InputDecoration(
                                          hintTextDirection: TextDirection.rtl,
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide:
                                              BorderSide(color: Colors.black)),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.black),
                                          ),
                                          labelText: 'حــالـه المريـض',
                                          labelStyle: TextStyle(color: Colors.grey),
                                          prefixIcon: Icon(
                                            Icons.info,
                                            color: Constants.redColor,
                                          ),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      //Phone number
                                      TextFormField(
                                        cursorColor: Constants.redColor,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'برجاء إدخال رقم هاتف لسهولة التواصل معك';
                                          }
                                          return null;
                                        },
                                        controller: phoneController,
                                        keyboardType: TextInputType.phone,
                                        style: TextStyle(color: Constants.redColor),
                                        decoration: InputDecoration(
                                          hintTextDirection: TextDirection.rtl,
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide:
                                              BorderSide(color: Colors.black)),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.black),
                                          ),
                                          labelText: 'رقم الهاتف',
                                          labelStyle: TextStyle(color: Colors.grey),
                                          prefixIcon: Icon(
                                            Icons.phone,
                                            color: Constants.redColor,
                                          ),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      //another phone number
                                      TextFormField(
                                        cursorColor: Constants.redColor,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'برجاء إدخال رقم هاتف آخر للإحتياط';
                                          }
                                          return null;
                                        },
                                        controller: anotherphoneController,
                                        keyboardType: TextInputType.phone,
                                        style: TextStyle(color: Constants.redColor),
                                        decoration: InputDecoration(
                                          hintTextDirection: TextDirection.rtl,
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide:
                                              BorderSide(color: Colors.black)),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.black),
                                          ),
                                          labelText: 'رقم هاتف أخر',
                                          labelStyle: TextStyle(color: Colors.grey),
                                          prefixIcon: Icon(
                                            Icons.phone,
                                            color: Constants.redColor,
                                          ),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      //Blood type
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14),
                                        child: Row(
                                          children: [
                                            Icon(Icons.bloodtype, color: Constants.redColor),
                                            SizedBox(width: 10),
                                            DropdownButton(
                                              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                                              alignment: Alignment.center,
                                              iconSize: 30,
                                              iconEnabledColor: Constants.redColor,
                                              value: BloodType,
                                              hint: Text(
                                                'أختر فصيلة الدم',
                                                style: TextStyle(color: Colors.grey),
                                              ),
                                              items: [
                                                DropdownMenuItem(
                                                  child: Center(
                                                      child: defaultText(text: 'O+')),
                                                  value: 'O+',
                                                ),
                                                DropdownMenuItem(
                                                  child: Center(
                                                      child: defaultText(text: 'O-')),
                                                  value: 'O-',
                                                ),
                                                DropdownMenuItem(
                                                  child: Center(
                                                      child: defaultText(text: 'A+')),
                                                  value: 'A+',
                                                ),
                                                DropdownMenuItem(
                                                  child: Center(
                                                      child: defaultText(text: 'A-')),
                                                  value: 'A-',
                                                ),
                                                DropdownMenuItem(
                                                  child: Center(
                                                      child: defaultText(text: 'B+')),
                                                  value: 'B+',
                                                ),
                                                DropdownMenuItem(
                                                  child: Center(
                                                      child: defaultText(text: 'B-')),
                                                  value: 'B-',
                                                ),
                                                DropdownMenuItem(
                                                  child: Center(
                                                      child:
                                                      defaultText(text: 'AB+')),
                                                  value: 'AB+',
                                                ),
                                                DropdownMenuItem(
                                                  child: Center(
                                                      child:
                                                      defaultText(text: 'AB-')),
                                                  value: 'AB-',
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
                                      Divider(
                                        height: 5,
                                        color: Colors.black,
                                        thickness: 1,
                                      ),
                                      // Age
                                      TextFormField(
                                        cursorColor: Constants.redColor,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'برجاء إدخال سن المريض';
                                          }
                                          return null;
                                        },
                                        controller: ageController,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(color: Constants.redColor),
                                        decoration: InputDecoration(
                                          hintTextDirection: TextDirection.rtl,
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide:
                                              BorderSide(color: Colors.black)),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.black),
                                          ),
                                          labelText: 'سـن المريـض',
                                          labelStyle: TextStyle(color: Colors.grey),
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: Constants.redColor,
                                          ),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      //hospital address
                                      TextFormField(
                                        cursorColor: Constants.redColor,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'برجاء إدخال المستشفى أو المكان الذي سيتم فيه التبرع';
                                          }
                                          return null;
                                        },
                                        controller: hospitalController,
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(color: Constants.redColor),
                                        decoration: InputDecoration(
                                          hintTextDirection: TextDirection.rtl,
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide:
                                              BorderSide(color: Colors.black)),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.black),
                                          ),
                                          labelText: 'اسم المستشفى وعنوانها',
                                          labelStyle: TextStyle(color: Colors.grey),
                                          prefixIcon: Icon(
                                            Icons.location_on,
                                            color: Constants.redColor,
                                          ),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      //blood amount needed
                                      TextFormField(
                                        cursorColor: Constants.redColor,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'برجاء إدخال عدد أكياس الدم المطلوبة';
                                          }
                                          return null;
                                        },
                                        controller: bloodamountController,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(color: Constants.redColor),
                                        decoration: InputDecoration(
                                          hintTextDirection: TextDirection.rtl,
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide:
                                              BorderSide(color: Colors.black)),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.black),
                                          ),
                                          labelText: 'عدد أكياس الدم المطلوبه',
                                          labelStyle: TextStyle(color: Colors.grey),
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: Constants.redColor,
                                          ),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 40,
                              ),
                              //Submit Button
                              Container(
                                height: 60,
                                width: 300,
                                decoration: BoxDecoration(
                                  color: Constants.redColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextButton(
                                  onPressed: (){
                                    if (formKey.currentState!.validate()) {
                                      final firestoreInstance =
                                          FirebaseFirestore.instance;
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
                                              image: Image.network('https://media.tenor.com/images/2525ba72ea472c55bf8b2153e9ea9f11/tenor.gif'),
                                              title: 'تم إرسال البيانات بنجاح',
                                              description1:
                                              'تم إرسال البيانات وسيتم التواصل معك في أقرب فرصة',
                                              description2: '',
                                            )).then((value) =>
                                            navigateTo(context, home_page())),
                                      );
                                    };
                                  },
                                  child: Text(
                                    'إرسـال البيـانـات',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Navigation
                ),
              );
            },
          );
        }
      ),
    );
  }
}
