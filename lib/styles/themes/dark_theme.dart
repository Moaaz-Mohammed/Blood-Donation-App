import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/constants.dart';
import '../custom_colors.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: CustomColors.primaryDarkColor,
  primaryColor: CustomColors.primaryRedColor,
  appBarTheme: const AppBarTheme(
    // ignore: deprecated_member_use
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: CustomColors.primaryDarkColor,
      statusBarIconBrightness: Brightness.light,
    ),
    iconTheme: IconThemeData(
      color: CustomColors.primaryGreyColor,
    ),
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 20.0,
      color: CustomColors.primaryGreyColor,
    ),
    centerTitle: true,
    backgroundColor: CustomColors.primaryDarkColor,
    elevation: 0.0,
    titleSpacing: 20.0,
  ),
  iconTheme: const IconThemeData(color: CustomColors.primaryGreyColor),
  primaryIconTheme: IconThemeData(color: CustomColors.primaryDarkMColor),
  splashColor: CustomColors.primaryRedColor,
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: CustomColors.primaryDarkMColor,
    ),
    headline2: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: CustomColors.primaryDarkMColor,
    ),
    headline3: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: CustomColors.primaryDarkMColor,
    ),
    headline4: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: CustomColors.primaryDarkMColor,
    ),
    headline5: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: CustomColors.primaryDarkMColor,
    ),
    headline6: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: CustomColors.primaryDarkMColor,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      color: CustomColors.primaryDarkMColor,
    ),
  ),
  dividerColor: CustomColors.primaryDarkMColor,
  backgroundColor: CustomColors.primaryDarkColor,
  hoverColor: CustomColors.primaryDarkColor,
  focusColor: CustomColors.primaryDarkColor,
  cardColor: CustomColors.primaryDarkColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: CustomColors.primaryDarkColor,
    elevation: 2,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: CustomColors.primaryWhiteColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    suffixIconColor: CustomColors.primaryRedColor,
    prefixIconColor: CustomColors.primaryRedColor,
    focusColor: CustomColors.primaryRedColor,
    hintStyle: const TextStyle(
      color: CustomColors.primaryWhiteColor,
      fontSize: 14,
    ),
    labelStyle: const TextStyle(
      color: CustomColors.primaryRedColor,
      fontSize: 14,
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
    contentPadding:
        const EdgeInsets.symmetric(vertical: 22.0, horizontal: 20.0),
  ),
  timePickerTheme: const TimePickerThemeData(),
);
