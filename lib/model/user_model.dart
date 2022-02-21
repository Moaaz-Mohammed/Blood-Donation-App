import 'package:cloud_firestore/cloud_firestore.dart';

import '../shared/strings.dart';

class UserModel {
  String? userId;
  String? userName;
  String? userDateofBirth;
  String? userLastDonation;
  String? userBloodType;
  String? userEmail;
  String? userAddress;
  String? userPhone;
  String? userStatus;

  UserModel({
    required this.userId,
    required this.userName,
    required this.userDateofBirth,
    required this.userLastDonation,
    required this.userBloodType,
    required this.userEmail,
    required this.userAddress,
    required this.userPhone,
    required this.userStatus,
  });

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : userBloodType = snapshot[Strings.userBloodType];
}
