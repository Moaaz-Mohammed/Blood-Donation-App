import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Components.dart';

ThemeData darktheme = ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  primaryColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    toolbarHeight: 50,
      titleSpacing: 20.0,
      backgroundColor: HexColor('333739'),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      elevation: 5,
      iconTheme: IconThemeData(color: Colors.white)),
  textTheme: TextTheme(
    bodyText1: TextStyle(

      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ), textSelectionTheme: TextSelectionThemeData(cursorColor: color),
);
ThemeData lighttheme = ThemeData(
  floatingActionButtonTheme:
    FloatingActionButtonThemeData(backgroundColor: Colors.teal),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      toolbarHeight: 50,
        titleSpacing: 20.0,
        backgroundColor: Colors.white,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.grey[100],
          statusBarIconBrightness: Brightness.dark,
        ),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        elevation: 5,
        iconTheme: IconThemeData(color: color)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: color,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      elevation: 30,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ), textSelectionTheme: TextSelectionThemeData(cursorColor: color));
