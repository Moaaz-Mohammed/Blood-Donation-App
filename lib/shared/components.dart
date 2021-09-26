import 'dart:io';
import 'package:blood_donation/Modules/Blood_Donation_Benf.dart';
import 'package:blood_donation/Modules/Mail_Page.dart';
import 'package:blood_donation/Modules/Need_Donation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../Home.dart';
import 'Cubit/Cubit.dart';

Color? color = Colors.red[300];


navigateTo(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Widget TitleText({@required String? text}) => Text(
      text!,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );

Widget DefaultButton(context,{required Function()? function,required String? text}) => Container(
      height: 60,
      width: 300,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: function!,
        child: Text(
          text!,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        ),
      ),
    );


Widget defaultText({@required String? text,}) => Text(
      text!,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: color),
    );

Widget dText({@required String? text,}) => Text(text!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),);

class CustomDialog extends StatelessWidget {
  final String? title, description1, description2, buttonText;
  final Image? image;

  CustomDialog(
      {
      this.title,
      this.buttonText,
      this.description1,
      this.description2,
      this.image,
      }
      );
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
  dialogContent(BuildContext context) {
    return Stack(
      children: [
        Container(
            padding: EdgeInsets.only(top: 80, bottom: 5, left: 16, right: 16),
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.red.shade200,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0))
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  title!,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  height: 16,
                ),
                Text(
                  description1!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  description2!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            )),
      ],
    );
  }
}

Widget CustomDrawer(context) => Drawer(
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
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 2,
                    insetAnimationCurve: Curves.easeInOutQuart,
                    backgroundColor: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                            imageUrl: 'https://i.ibb.co/H24z3fQ/blood.png'),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Close',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                );
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

Widget ArticleHeadText({@required String? text,}) =>Text(
      text!,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
    );

Widget ArticleContentText({@required String? text,}) => Text(
      text!,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
    );

Widget DetailtsText ({required String? text})=>Text(text!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),);

