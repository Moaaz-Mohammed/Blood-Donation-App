import 'dart:io';

import 'package:blood_donation/Home.dart';
import 'package:blood_donation/Screens/BloodTypes.dart';
import 'package:blood_donation/Screens/Blood_Donation_Benf.dart';
import 'package:blood_donation/Screens/Mail_Page.dart';
import 'package:blood_donation/Screens/Need_Donation.dart';
import 'package:blood_donation/shared/Constants.dart';
import 'package:blood_donation/shared/Cubit/Cubit.dart';
import 'package:blood_donation/shared/components.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

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
                  color: AppCubit.get(context).isDark? HexColor('333739') : Colors.white,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0))
            ]
        ),

        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(child: Center(child: Text('معاً ننقذ حياة',style: TextStyle(fontSize: 26)))),
            ListTile(
              leading: Icon(Icons.home,color: color),
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
            Divider(thickness: 1, color: Colors.black),
            //Patients
            ListTile(
              leading: Icon(Icons.info,color: color),
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
            Divider(thickness: 1, color: Colors.black),
            //BloodType Info.
            ListTile(
              leading: Icon(Icons.bloodtype,color: color,),
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
            Divider(thickness: 1, color: Colors.black),
            //Info before donation
            ListTile(
              leading: Icon(Icons.info,color: color),
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
            Divider(thickness: 1, color: Colors.black),
            //Mail
            ListTile(
              leading: Icon(Icons.message,color: color),
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
            Divider(thickness: 1, color: Colors.black),
            //Exit App
            ListTile(
              leading: Icon(Icons.logout,color: color),
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
