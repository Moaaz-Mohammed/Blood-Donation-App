import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Screens/home/new_home_screen.dart';
import '../model/user_model.dart';
import '../shared/Constants.dart';
import '../shared/Functions.dart';

class Store {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  /// After Sign in Update User Information In Firebase Firestore
  Future addUser(UserModel userModel) async {
    fireStore.collection(Constants.usersCollection).doc(userModel.userId).set(
      {
        Constants.userId: userModel.userId,
        Constants.userName: userModel.userName,
        Constants.userDateofBirth: userModel.userDateofBirth,
        Constants.userLastDonation: userModel.userLastDonation,
        Constants.userEmail: userModel.userEmail,
        Constants.userPhone: userModel.userPhone,
        Constants.userAddress: userModel.userAddress,
        Constants.userBloodType: userModel.userBloodType,
        Constants.userStatus: userModel.userStatus,
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
    fireStore.collection(Constants.usersCollection).doc(userId).update(
      {
        Constants.userName: userName,
        Constants.userDateofBirth: userDateofBirth,
        Constants.userPhone: userPhone,
        Constants.userAddress: userLocation,
      },
    ).then(
      (value) {
        Functions.navigatorPushAndRemove(
          context: context,
          screen: NewHomeScreen(),
        );
        Functions.showToastMsg(
          title: 'تم تعديل بياناتك بنجاح',
        );
      },
    );
  }
}
