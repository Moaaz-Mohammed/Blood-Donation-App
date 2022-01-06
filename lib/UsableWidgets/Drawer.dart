import 'dart:io';
import 'package:blood_donation/Home.dart';
import 'package:blood_donation/Screens/BloodTypes.dart';
import 'package:blood_donation/Screens/Blood_Donation_Benf.dart';
import 'package:blood_donation/Screens/Mail_Page.dart';
import 'package:blood_donation/Screens/Need_Donation.dart';
import 'package:blood_donation/shared/Constants.dart';
import 'package:blood_donation/shared/Cubit/Cubit.dart';
import 'package:blood_donation/shared/components.dart';
import 'package:flutter/material.dart';

import '../Styles/CustomColors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Container(
        decoration:BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: AppCubit.get(context).isDark? CustomColors.primaryRedColor : CustomColors.primaryWhiteColor,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0))
            ]
        ),

        child: Column(
          // scrollDirection: Axis.vertical,
          // padding: EdgeInsets.zero,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DrawerHeader(child: Center(child: Text('معاً ننقذ حياة',style: TextStyle(fontSize: 26)))),
            ListTile(
              leading: Icon(Icons.home,color: Constants.redColor),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  defaultText(text: 'الرئيسية'),
                ],
              ),
              onTap: () {
                navigateTo(context, home_page());
              },
            ),
            //Patients
            ListTile(
              leading: Icon(Icons.info,color: Constants.redColor),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  defaultText(text: 'محتاجون للتبرع'),
                ],
              ),
              onTap: () {
                navigateTo(context,Need_Donation());
              },
            ),
            //BloodType Info.
            ListTile(
              leading: Icon(Icons.bloodtype,color: Constants.redColor,),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  defaultText(text: 'فصائل الدم'),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>BloodTypes()));
              },
            ),
            //Info before donation
            ListTile(
              leading: Icon(Icons.info,color: Constants.redColor),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  defaultText(text: 'معلومات هامة قبل التبرع'),
                ],
              ),
              onTap: () {
                navigateTo(context, Blood_Donation_Benf());
              },
            ),
            //Mail
            ListTile(
              leading: Icon(Icons.message,color: Constants.redColor),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  defaultText(text: 'تواصل معنا'),
                ],
              ),
              onTap: () {
                navigateTo(context, Mail());
              },
            ),
            //Exit App
            ListTile(
              leading: Icon(Icons.logout,color: Constants.redColor),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  defaultText(text: 'خـروج'),
                ],
              ),
              onTap: ()=> exit(0),
            ),
          ],
        ),
      ),
    );
  }
}
