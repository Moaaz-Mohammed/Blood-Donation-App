import 'package:cloud_firestore/cloud_firestore.dart';

import '../shared/Constants.dart';

class UserModel {
  var userId;
  var userName;
  var userDateofBirth;
  var userBloodType;
  var userEmail;
  var userAddress;
  var userPhone;
  var userImageUrl;
  var userStatus;

  UserModel({
    required this.userId,
    required this.userName,
    required this.userDateofBirth,
    required this.userBloodType,
    required this.userEmail,
    required this.userAddress,
    required this.userPhone,
    required this.userImageUrl,
    required this.userStatus,
  });

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : userName = snapshot[Constants.userName];
}
