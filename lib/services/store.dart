import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Screens/home/home_screen.dart';
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
        Constants.userEmail: userModel.userEmail,
        Constants.userPhone: userModel.userPhone,
        Constants.userAddress: userModel.userLocation,
        Constants.userImageUrl: userModel.userImageUrl,
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
    required userImageUrl,
    required context,
  }) async {
    fireStore.collection(Constants.usersCollection).doc(userId).update(
      {
        Constants.userName: userName,
        Constants.userDateofBirth: userDateofBirth,
        Constants.userPhone: userPhone,
        Constants.userAddress: userLocation,
        Constants.userImageUrl: userImageUrl,
      },
    ).then(
      (value) {
        Functions.navigatorPushAndRemove(
          context: context,
          screen: HomeScreen(),
        );
        Functions.showToastMsg(
          title: 'تم تعديل بياناتك بنجاح',
        );
      },
    );
  }

}
