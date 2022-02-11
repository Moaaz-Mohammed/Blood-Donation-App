import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/Constants.dart';
import '../CustomColors.dart';

ThemeData LightTheme = ThemeData(
  scaffoldBackgroundColor: CustomColors.primaryWhiteColor,
  primaryColor: CustomColors.primaryRedColor,
  appBarTheme: const AppBarTheme(
    // ignore: deprecated_member_use
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: CustomColors.primaryWhiteColor,
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(
      color: CustomColors.primaryRedColor,
    ),
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 20.0,
      color: CustomColors.primaryRedColor,
    ),
    centerTitle: true,
    backgroundColor: CustomColors.primaryWhiteColor,
    elevation: 0.0,
    titleSpacing: 20.0,
  ),
  iconTheme: const IconThemeData(color: CustomColors.primaryDarkColor),
  primaryIconTheme: const IconThemeData(color: CustomColors.primaryDarkColor),
  splashColor: CustomColors.primaryWhiteColor,
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: CustomColors.primaryDarkColor,
    ),
    headline2: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: CustomColors.primaryDarkColor,
    ),
    headline3: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: CustomColors.primaryDarkColor,
    ),
    headline4: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: CustomColors.primaryDarkColor,
    ),
    headline5: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: CustomColors.primaryDarkColor,
    ),
    labelMedium: TextStyle(fontSize: 14, color: CustomColors.primaryDarkColor),
  ),
  dividerColor: CustomColors.primaryDarkColor,
  backgroundColor: CustomColors.primaryWhiteColor,
  hoverColor: CustomColors.primaryWhiteColor,
  focusColor: CustomColors.primaryWhiteColor,
  cardColor: CustomColors.primaryWhiteColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: CustomColors.primaryRedColor),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: CustomColors.primaryRedColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: CustomColors.primaryRedColor,
    disabledBorder: UnderlineInputBorder(
      borderRadius: Constants.primaryBorderRadius,
      borderSide: const BorderSide(
        color: CustomColors.primaryGreyColor,
      ),
    ),
    focusColor: CustomColors.primaryRedColor,
    suffixIconColor: CustomColors.primaryRedColor,
    hintStyle: const TextStyle(
      color: CustomColors.primaryDarkColor,
      fontSize: 13,
    ),
    labelStyle: const TextStyle(
      color: CustomColors.primaryRedColor,
      fontSize: 15,
    ),
    enabledBorder: UnderlineInputBorder(
      borderRadius: Constants.primaryBorderRadius,
      borderSide: const BorderSide(
        color: CustomColors.primaryGreyColor,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderRadius: Constants.primaryBorderRadius,
      borderSide: const BorderSide(
        color: CustomColors.primaryRedColor,
      ),
    ),
    filled: true,
    fillColor: CustomColors.primaryGreyColor,
    contentPadding:
        const EdgeInsets.symmetric(vertical: 22.0, horizontal: 20.0),
  ),
);
