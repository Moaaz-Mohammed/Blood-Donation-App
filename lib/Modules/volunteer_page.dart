import 'package:blood_donation/shared/Controllers.dart';
import 'package:blood_donation/shared/Cubit/Cubit.dart';
import 'package:blood_donation/shared/Cubit/States.dart';
import 'package:blood_donation/shared/components.dart';
import 'package:blood_donation/shared/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Home.dart';

class Volunteer extends StatefulWidget {
  @override
  _VolunteerState createState() => _VolunteerState();
}

class _VolunteerState extends State<Volunteer> {
  var BloodType;
  var Status;
  var ShareData;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
        create: (context)=>AppCubit(),
      child:BlocBuilder<AppCubit,AppStates>
        (
        builder: (context,state)
        {
          return MaterialApp(
            themeMode: ThemeMode.system,
            theme:lighttheme,
            darkTheme: darktheme,
            debugShowCheckedModeBanner: false,
            builder: (context, child)
            {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: SafeArea(
                  child: Scaffold(
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
                            color: Colors.red,
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
                                //Head Title
                                Column(
                                  children: [
                                    Divider(thickness: 1,),
                                    Text(
                                      'برجاء التأكد عند تسجيل بياناتك',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                      ),
                                    ),
                                    Divider(thickness: 1,color: color,),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                //name
                                TextFormField(
                                  cursorColor: color,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'برجاء كتابة إسم المتبرع';
                                    }
                                    return null;
                                  },
                                  controller: namecontroller,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: color),
                                  decoration: InputDecoration(
                                    hintTextDirection: TextDirection.rtl,
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black)),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    labelText: 'اسم المتبرع او ("فاعل خير")',
                                    labelStyle: const TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: color,
                                    ),
                                    border: const OutlineInputBorder(),
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
                                        Icon(Icons.error, color: color),
                                        const SizedBox(width: 10),
                                        Text("هل تعاني من أمراض؟",style: TextStyle(fontSize: 15,color:Colors.grey),),
                                        DropdownButton(
                                          alignment: Alignment.center,
                                          dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                                          iconSize: 30,
                                          iconEnabledColor: color,
                                          value: Status,
                                          hint: const Text(
                                            'أختر',
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          items: [
                                            DropdownMenuItem(
                                              child: Center(
                                                  child: defaultText(text: 'لا توجد أمراض مزمنة')),
                                              value: 'لا توجد أمراض مزمنة',
                                            ),
                                            DropdownMenuItem(
                                              child: Center(
                                                  child: defaultText(text: 'أمراض فقر الدم')),
                                              value: 'أمراض فقر الدم',
                                            ),
                                            DropdownMenuItem(
                                              child: Center(
                                                  child: defaultText(text: 'أمراض الدم الوراثيه')),
                                              value: 'أمراض الدم الوراثيه',
                                            ),
                                            DropdownMenuItem(
                                              child: Center(
                                                  child: defaultText(text: 'إلتهاب الكبد الفيروسي C - B')),
                                              value: 'إلتهاب الكبد الفيروسي C - B',
                                            ),
                                            DropdownMenuItem(
                                              child: Center(
                                                  child: defaultText(text: 'الإيدز - الملاريا - الزهري')),
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
                                              Status = value;
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
                                      Icon(Icons.person, color: color),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'تاريخ الميلاد',
                                        style: TextStyle(color: Colors.grey,fontSize: 16),
                                      ),
                                      SizedBox(width: 15,),
                                      Expanded(
                                        child:TextFormField(
                                          cursorColor: color,
                                          textAlignVertical: TextAlignVertical.center,
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return 'يوم الميلاد';
                                            }
                                            return null;
                                          },
                                          controller: daycontroller,
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(color: color),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            labelText: 'اليوم',
                                            labelStyle: const TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child:TextFormField(
                                          cursorColor: color,
                                          textAlignVertical: TextAlignVertical.center,
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return 'شهر الميلاد';
                                            }
                                            return null;
                                          },
                                          controller: monthcontroller,
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(color: color),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            labelText: 'الشهر',
                                            labelStyle: const TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child:TextFormField(
                                          cursorColor: color,
                                          textAlignVertical: TextAlignVertical.center,
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return 'سنة الميلاد';
                                            }
                                            return null;
                                          },
                                          controller: yearcontroller,
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(color: color),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            labelText: 'السنة',
                                            labelStyle: const TextStyle(color: Colors.grey),
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
                                      Icon(Icons.bloodtype, color: color),
                                      const SizedBox(width: 10),
                                      DropdownButton(
                                        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                                        alignment: Alignment.center,
                                        iconSize: 30,
                                        iconEnabledColor: color,
                                        value: BloodType,
                                        hint: const Text(
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
                                                child: defaultText(text: 'AB+')),
                                            value: 'AB+',
                                          ),
                                          DropdownMenuItem(
                                            child: Center(
                                                child: defaultText(text: 'AB-')),
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
                                const Divider(
                                  height: 5,
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                                //phone number
                                TextFormField(
                                  cursorColor: color,
                                  validator: (String? value) {
                                    if (value!.isEmpty){
                                      return 'برجاء كتابة رقم هاتف';
                                    }
                                    else if(value.length!=11)
                                      {
                                        return 'برجاء كتابة رقم هاتف صحيح';
                                      }
                                  },
                                  controller: phonecontroller,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(color: color),
                                  decoration: InputDecoration(
                                    hintTextDirection: TextDirection.rtl,
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black)),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    labelText: 'رقم الهاتف',
                                    labelStyle: const TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: color,
                                    ),
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                //another phone number
                                TextFormField(
                                  cursorColor: color,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'برجاء إدخال رقم هاتف آخر للإحتياط';
                                    }
                                    return null;
                                  },
                                  controller: anotherphonecontroller,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(color: color),
                                  decoration: InputDecoration(
                                    hintTextDirection: TextDirection.rtl,
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black)),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    labelText: 'رقم هاتف أخر',
                                    labelStyle: const TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: color,
                                    ),
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                //Facebook
                                TextFormField(
                                  cursorColor: color,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'برجاء كتابة اسمك على Facebook';
                                    }
                                    return null;
                                  },
                                  controller: Facebookcontroller,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: color),
                                  decoration: InputDecoration(
                                    hintTextDirection: TextDirection.rtl,
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black)),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    labelText: 'Facebook',
                                    labelStyle: const TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(
                                      Icons.facebook_rounded,
                                      color: color,
                                    ),
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                //Last Donation
                                TextFormField(
                                  cursorColor: color,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'برجاء كتابة أخر مره قمت بالتبرع فيها';
                                    }
                                    return null;
                                  },
                                  controller: LastDonationcontroller,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: color),
                                  decoration: InputDecoration(
                                    hintTextDirection: TextDirection.rtl,
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black)),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    labelText: 'متى كان آخر تبرع لك؟',
                                    labelStyle: const TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(
                                      Icons.access_time,
                                      color: color,
                                    ),
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                //Address
                                TextFormField(
                                  cursorColor: color,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'برجاء كتابة عنوانك';
                                    }
                                    return null;
                                  },
                                  controller: addresscontroller,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: color),
                                  decoration: InputDecoration(
                                    hintTextDirection: TextDirection.rtl,
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black)),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    labelText: 'العـنـوان',
                                    labelStyle: const TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(
                                      Icons.location_on,
                                      color: color,
                                    ),
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                                //Share Data
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 14),
                                  child: Row(
                                    children: [
                                      Icon(Icons.share, color: color),
                                      const SizedBox(width: 10),
                                      Text("هل تسمح بنشر بياناتك؟",style: TextStyle(fontSize: 15,color:Colors.grey),),
                                      SizedBox(width:10),
                                      DropdownButton(
                                        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                                        alignment: Alignment.center,
                                        iconSize: 30,
                                        iconEnabledColor: color,
                                        value: ShareData,
                                        hint: const Text(
                                          'أختر',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        items: [
                                          DropdownMenuItem(
                                            child: Center(
                                                child: defaultText(text: 'نعم')),
                                            value: 'نعم',
                                          ),
                                          DropdownMenuItem(
                                            child: Center(
                                                child: defaultText(text: 'لا')),
                                            value: 'لا',
                                          ),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            ShareData = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                DefaultButton(context,
                                    function: () {
                                      if (formKey.currentState!.validate())
                                      {
                                        final firestoreInstance =
                                            FirebaseFirestore.instance;
                                        firestoreInstance
                                            .collection("Volunteer")
                                            .add({
                                          "facebook":Facebookcontroller.text,
                                          "share_data":ShareData.toString(),
                                          "name": namecontroller.text,
                                          "status": Status.toString(),
                                          "day_of_birth": daycontroller.text,
                                          "month_of_birth": monthcontroller.text,
                                          "year_of_birth": yearcontroller.text,
                                          "blood_type": BloodType.toString(),
                                          "phone": phonecontroller.text,
                                          "another_phone":anotherphonecontroller.text,
                                          "last_donation":LastDonationcontroller.text,
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
                                            navigateTo(context, home_page())));
                                      }
                                      ;
                                    },
                                    text: 'إرســال البيـانـات')
                              ],
                            ),
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
        },
      ),
    );
  }
}

