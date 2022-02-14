import 'package:blood_donation/shared/Controllers.dart';
import 'package:blood_donation/shared/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Styles/CustomColors.dart';
import 'home/home_screen.dart';

class Volunteer extends StatefulWidget {
  const Volunteer({Key? key}) : super(key: key);

  @override
  _VolunteerState createState() => _VolunteerState();
}

class _VolunteerState extends State<Volunteer> {
  var bloodType;
  var status;
  var shareData;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(text: 'تسجيل بيانات متبرع'),
        centerTitle: true,
        leading: const Text(''),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_forward_ios,
              color: CustomColors.primaryRedColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //name
                  TextFormField(
                    cursorColor: CustomColors.primaryRedColor,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'برجاء كتابة إسم المتبرع';
                      }
                      return null;
                    },
                    controller: namecontroller,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: CustomColors.primaryRedColor),
                    decoration: const InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'اسم المتبرع او ("فاعل خير")',
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.person,
                        color: CustomColors.primaryRedColor,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //status of the donaitor
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          const Icon(Icons.error,
                              color: CustomColors.primaryRedColor),
                          const SizedBox(width: 10),
                          const Text(
                            "هل تعاني من أمراض؟",
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                          DropdownButton(
                            alignment: Alignment.center,
                            dropdownColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            iconSize: 30,
                            iconEnabledColor: CustomColors.primaryRedColor,
                            value: status,
                            hint: const Text(
                              'أختر',
                              style: TextStyle(color: Colors.grey),
                            ),
                            items: [
                              DropdownMenuItem(
                                child: Center(
                                    child: defaultText(
                                        text: 'لا توجد أمراض مزمنة')),
                                value: 'لا توجد أمراض مزمنة',
                              ),
                              DropdownMenuItem(
                                child: Center(
                                    child: defaultText(text: 'أمراض فقر الدم')),
                                value: 'أمراض فقر الدم',
                              ),
                              DropdownMenuItem(
                                child: Center(
                                    child: defaultText(
                                        text: 'أمراض الدم الوراثيه')),
                                value: 'أمراض الدم الوراثيه',
                              ),
                              DropdownMenuItem(
                                child: Center(
                                    child: defaultText(
                                        text: 'إلتهاب الكبد الفيروسي C - B')),
                                value: 'إلتهاب الكبد الفيروسي C - B',
                              ),
                              DropdownMenuItem(
                                child: Center(
                                    child: defaultText(
                                        text: 'الإيدز - الملاريا - الزهري')),
                                value: 'الإيدز - الملاريا - الزهري',
                              ),
                              DropdownMenuItem(
                                child: Center(
                                    child: defaultText(text: 'أمراض السرطان')),
                                value: 'أمراض السرطان',
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                status = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 5,
                    color: Colors.black,
                    thickness: 1,
                  ),
                  //date of birth
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        const Icon(Icons.person,
                            color: CustomColors.primaryRedColor),
                        const SizedBox(width: 10),
                        const Text(
                          'تاريخ الميلاد',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextFormField(
                            cursorColor: CustomColors.primaryRedColor,
                            textAlignVertical: TextAlignVertical.center,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'يوم الميلاد';
                              }
                              return null;
                            },
                            controller: daycontroller,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                color: CustomColors.primaryRedColor),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              labelText: 'اليوم',
                              labelStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            cursorColor: CustomColors.primaryRedColor,
                            textAlignVertical: TextAlignVertical.center,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'شهر الميلاد';
                              }
                              return null;
                            },
                            controller: monthcontroller,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                color: CustomColors.primaryRedColor),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              labelText: 'الشهر',
                              labelStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            cursorColor: CustomColors.primaryRedColor,
                            textAlignVertical: TextAlignVertical.center,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'سنة الميلاد';
                              }
                              return null;
                            },
                            controller: yearcontroller,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                color: CustomColors.primaryRedColor),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              labelText: 'السنة',
                              labelStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 5,
                    color: Colors.black,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Blood Type
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        const Icon(Icons.bloodtype,
                            color: CustomColors.primaryRedColor),
                        const SizedBox(width: 10),
                        DropdownButton(
                          dropdownColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          alignment: Alignment.center,
                          iconSize: 30,
                          iconEnabledColor: CustomColors.primaryRedColor,
                          value: bloodType,
                          hint: const Text(
                            'أختر فصيلة الدم',
                            style: TextStyle(color: Colors.grey),
                          ),
                          items: [
                            DropdownMenuItem(
                              child: Center(child: defaultText(text: 'O+')),
                              value: 'O+',
                            ),
                            DropdownMenuItem(
                              child: Center(child: defaultText(text: 'O-')),
                              value: 'O-',
                            ),
                            DropdownMenuItem(
                              child: Center(child: defaultText(text: 'A+')),
                              value: 'A+',
                            ),
                            DropdownMenuItem(
                              child: Center(child: defaultText(text: 'A-')),
                              value: 'A-',
                            ),
                            DropdownMenuItem(
                              child: Center(child: defaultText(text: 'B+')),
                              value: 'B+',
                            ),
                            DropdownMenuItem(
                              child: Center(child: defaultText(text: 'B-')),
                              value: 'B-',
                            ),
                            DropdownMenuItem(
                              child: Center(child: defaultText(text: 'AB+')),
                              value: 'AB+',
                            ),
                            DropdownMenuItem(
                              child: Center(child: defaultText(text: 'AB-')),
                              value: 'AB-',
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              bloodType = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 5,
                    color: Colors.black,
                    thickness: 1,
                  ),
                  //phone number
                  TextFormField(
                    cursorColor: CustomColors.primaryRedColor,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'برجاء كتابة رقم هاتف';
                      } else if (value.length != 11) {
                        return 'برجاء كتابة رقم هاتف صحيح';
                      }
                    },
                    controller: phonecontroller,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: CustomColors.primaryRedColor),
                    decoration: const InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'رقم الهاتف',
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: CustomColors.primaryRedColor,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //another phone number
                  TextFormField(
                    cursorColor: CustomColors.primaryRedColor,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'برجاء إدخال رقم هاتف آخر للإحتياط';
                      }
                      return null;
                    },
                    controller: anotherphonecontroller,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: CustomColors.primaryRedColor),
                    decoration: const InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'رقم هاتف أخر',
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: CustomColors.primaryRedColor,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Facebook
                  TextFormField(
                    cursorColor: CustomColors.primaryRedColor,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'برجاء كتابة اسمك على Facebook';
                      }
                      return null;
                    },
                    controller: Facebookcontroller,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: CustomColors.primaryRedColor),
                    decoration: const InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Facebook',
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.facebook_rounded,
                        color: CustomColors.primaryRedColor,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Last Donation
                  TextFormField(
                    cursorColor: CustomColors.primaryRedColor,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'برجاء كتابة أخر مره قمت بالتبرع فيها';
                      }
                      return null;
                    },
                    controller: LastDonationcontroller,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: CustomColors.primaryRedColor),
                    decoration: const InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'متى كان آخر تبرع لك؟',
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.access_time,
                        color: CustomColors.primaryRedColor,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Address
                  TextFormField(
                    cursorColor: CustomColors.primaryRedColor,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'برجاء كتابة عنوانك';
                      }
                      return null;
                    },
                    controller: addresscontroller,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: CustomColors.primaryRedColor),
                    decoration: const InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'العـنـوان',
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: CustomColors.primaryRedColor,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  //Share Data
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        const Icon(Icons.share,
                            color: CustomColors.primaryRedColor),
                        const SizedBox(width: 10),
                        const Text(
                          "هل تسمح بنشر بياناتك؟",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        const SizedBox(width: 10),
                        DropdownButton(
                          dropdownColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          alignment: Alignment.center,
                          iconSize: 30,
                          iconEnabledColor: CustomColors.primaryRedColor,
                          value: shareData,
                          hint: const Text(
                            'أختر',
                            style: TextStyle(color: Colors.grey),
                          ),
                          items: [
                            DropdownMenuItem(
                              child: Center(child: defaultText(text: 'نعم')),
                              value: 'نعم',
                            ),
                            DropdownMenuItem(
                              child: Center(child: defaultText(text: 'لا')),
                              value: 'لا',
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              shareData = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 60,
                    width: 300,
                    decoration: BoxDecoration(
                      color: CustomColors.primaryRedColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final firestoreInstance = FirebaseFirestore.instance;
                          firestoreInstance.collection("Volunteer").add({
                            "facebook": Facebookcontroller.text,
                            "share_data": shareData.toString(),
                            "name": namecontroller.text,
                            "status": status.toString(),
                            "day_of_birth": daycontroller.text,
                            "month_of_birth": monthcontroller.text,
                            "year_of_birth": yearcontroller.text,
                            "blood_type": bloodType.toString(),
                            "phone": phonecontroller.text,
                            "another_phone": anotherphonecontroller.text,
                            "last_donation": LastDonationcontroller.text,
                            "address": addresscontroller.text,
                            "registered_time": DateTime.now().toLocal(),
                          }).then((value) => showDialog(
                              context: context,
                              builder: (context) => CustomDialog(
                                    image: Image.network(
                                        'https://media.tenor.com/images/2525ba72ea472c55bf8b2153e9ea9f11/tenor.gif'),
                                    title: 'تم إرسال بياناتك بنجاح',
                                    description1:
                                        'شكراً لمساهمتك في فعل الخير ♥',
                                    description2: '',
                                  )).then((value) =>
                              navigateTo(context, const HomeScreen())));
                        }
                        ;
                      },
                      child: const Text(
                        'إرسـال البيـانـات',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
