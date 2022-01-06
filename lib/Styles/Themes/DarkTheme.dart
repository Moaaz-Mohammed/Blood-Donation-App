import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../shared/Constants.dart';
import '../CustomColors.dart';

ThemeData DarkTheme = ThemeData(
  scaffoldBackgroundColor: CustomColors.primaryDarkColor,
  primaryColor: CustomColors.primaryDarkColor,
  appBarTheme: AppBarTheme(
      toolbarHeight: 50,
      titleSpacing: 20.0,
      backgroundColor: CustomColors.primaryDarkColor,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: CustomColors.primaryDarkColor,
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
  ), textSelectionTheme: TextSelectionThemeData(cursorColor: Constants.redColor),
);