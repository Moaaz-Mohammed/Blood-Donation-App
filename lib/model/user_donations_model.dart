import 'package:cloud_firestore/cloud_firestore.dart';

import '../Styles/Strings.dart';

class UserDonationsModel {
  String? donationAddress;
  String? donationTime;
  String? donationDate;
  String? PatientName;
  String? donationNotes;

  UserDonationsModel({
    required this.donationAddress,
    required this.donationTime,
    required this.donationDate,
    required this.PatientName,
    required this.donationNotes,
  });

  UserDonationsModel.fromSnapshot(DocumentSnapshot snapshot)
      : PatientName = snapshot[Strings.PatientName];
}
