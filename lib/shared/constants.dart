import 'package:flutter/material.dart';

import '../Styles/custom_colors.dart';

class Constants {
  /// constants app Border Radius
  static BorderRadius primaryBorderRadius = BorderRadius.circular(10.0);
  static BorderRadius primaryBorderRadiusBottom = const BorderRadius.only(
    bottomLeft: Radius.circular(30.0),
    bottomRight: Radius.circular(30.0),
  );
  static EdgeInsets primaryPadding = const EdgeInsets.all(10.0);

  static BoxDecoration primaryBoxDecorationContainer = BoxDecoration(
    borderRadius: primaryBorderRadius,
    color: CustomColors.primaryGreyColor,
  );

  static BoxDecoration primaryDarkBoxDecorationContainer = BoxDecoration(
    borderRadius: primaryBorderRadius,
    color: CustomColors.primaryDarkColor,
  );

  static BoxDecoration primaryBoxDecorationProfile = BoxDecoration(
    color: CustomColors.primaryGreyColor,
    borderRadius: primaryBorderRadiusBottom,
  );
}
