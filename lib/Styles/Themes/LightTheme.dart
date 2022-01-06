import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/Constants.dart';

ThemeData LightTheme = ThemeData(
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
        iconTheme: IconThemeData(color: Constants.redColor)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Constants.redColor,
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
    ), textSelectionTheme: TextSelectionThemeData(cursorColor: Constants.redColor));