import 'package:blood_donation/translations/locale_keys.g.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Screens/home/new_home_screen.dart';
import '../model/user_donations_model.dart';
import '../model/user_model.dart';
import '../shared/functions.dart';
import '../shared/strings.dart';

class Store {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  /// After Sign in Update User Information In Firebase Firestore
  Future addUser(UserModel userModel) async {
    fireStore.collection(Strings.usersCollection).doc(userModel.userId).set(
      {
        Strings.userId: userModel.userId,
        Strings.userName: userModel.userName,
        Strings.userDateofBirth: userModel.userDateofBirth,
        Strings.userLastDonation: userModel.userLastDonation,
        Strings.userEmail: userModel.userEmail,
        Strings.userPhone: userModel.userPhone,
        Strings.userAddress: userModel.userAddress,
        Strings.userBloodType: userModel.userBloodType,
        Strings.userStatus: userModel.userStatus,
      },
    );
  }

  Future addDonation(UserDonationsModel donationsModel) async {
    var donationDoc = fireStore
        .collection(Strings.usersCollection)
        .doc(user?.uid)
        .collection(Strings.userDonationsHistoryCollection)
        .doc(donationsModel.PatientName);
    donationDoc.get().then(
      (value) {
        donationDoc.set(
          {
            Strings.hPatientName: donationsModel.PatientName,
            Strings.donationAddress: donationsModel.donationAddress,
            Strings.donationTime: donationsModel.donationTime,
            Strings.donationDate: donationsModel.donationDate,
            Strings.donationNotes: donationsModel.donationNotes,
          },
        ).then(
          (value) {
            Functions.showToastMsg(
              title: LocaleKeys.added_successfully.tr(),
            );
          },
        );
      },
    );
  }

  /// edit user profile
  Future editUserProfile({
    required userId,
    required userName,
    required userLocation,
    required userDateofBirth,
    required userPhone,
    required context,
  }) async {
    fireStore.collection(Strings.usersCollection).doc(userId).update(
      {
        Strings.userName: userName,
        Strings.userDateofBirth: userDateofBirth,
        Strings.userPhone: userPhone,
        Strings.userAddress: userLocation,
      },
    ).then(
      (value) {
        Functions.navigatorPushAndRemove(
          context: context,
          screen: const NewHomeScreen(),
        );
        Functions.showToastMsg(
          title: LocaleKeys.edited_successfully.tr(),
        );
      },
    );
  }

  Future DeleteProductFromCart({
    required title,
    required PatientName,
  }) async {
    FirebaseFirestore.instance
        .collection(Strings.usersCollection)
        .doc(user!.uid)
        .collection(Strings.userDonationsHistoryCollection)
        .doc(PatientName)
        .delete()
        .then((value) {
      Functions.showToastMsg(title: title);
    });
  }
}
