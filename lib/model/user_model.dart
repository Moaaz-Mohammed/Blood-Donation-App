import 'package:cloud_firestore/cloud_firestore.dart';

import '../shared/Constants.dart';

class UserModel {
  var userId;
  var userName;
  var userDateofBirth;
  var userEmail;
  var userLocation;
  var userPhone;
  var userImageUrl;

  UserModel({
    required this.userId,
    required this.userName,
    required this.userDateofBirth,
    required this.userEmail,
    required this.userLocation,
    required this.userPhone,
    required this.userImageUrl,
  });

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : userName = snapshot[Constants.userName];
}
