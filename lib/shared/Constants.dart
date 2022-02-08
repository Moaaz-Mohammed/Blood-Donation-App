import 'dart:ui';

import 'package:flutter/material.dart';

import '../Styles/CustomColors.dart';

class Constants {
  /// Firebase user collection
  static const String usersCollection = 'usersCollection';
  static const String userId = 'UserId';
  static const String userName = 'UserName';
  static const String userDateofBirth = 'userDateofBirth';
  static const String userLastDonation = 'userLastDonation';
  static const String userPhone = 'UserPhone';
  static const String userEmail = 'UserEmail';
  static const String userAddress = 'userAddress';
  static const String userImageUrl = 'UserImageUrl';
  static const String userStatus = 'UserStatus';
  static const String userBloodType = 'UserBloodType';

  /// constants app Border Radius
  static BorderRadius primaryBorderRadius = BorderRadius.circular(10.0);
  static BorderRadius primaryBorderRadiusBottom = BorderRadius.only(
    bottomLeft: Radius.circular(30.0),
    bottomRight: Radius.circular(30.0),
  );
  static EdgeInsets primaryPadding = const EdgeInsets.all(10.0);

  static BoxDecoration primaryBoxDecorationContainer = BoxDecoration(
    borderRadius: primaryBorderRadius,
    color: CustomColors.primaryGreyColor.withOpacity(0.3),
  );

  static BoxDecoration primaryBoxDecorationProfile = BoxDecoration(
    color: CustomColors.primaryGreyColor,
    borderRadius: primaryBorderRadiusBottom,
  );

  // Images
  static const String BloodTypesImage = 'assets/images/blood-types.png';
  static const String LogoImage = 'assets/images/logo.png';
  static const String addUserImage = 'assets/images/add_user_photo.png';
  static const String egFlag = 'assets/images/eg-flag.png';
  static const String ukFlag = 'assets/images/uk-flag.png';
  static const String waveImage = 'assets/images/wave.png';
  static const String helpImage = 'assets/images/help_others.png';
  static const String friendsImage = 'assets/images/friends.png';
}
