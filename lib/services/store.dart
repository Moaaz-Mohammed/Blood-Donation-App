import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Screens/home/home_screen.dart';
import '../Styles/Strings.dart';
import '../model/user_model.dart';
import '../shared/Functions.dart';

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
          screen: HomeScreen(),
        );
        Functions.showToastMsg(
          title: 'تم تعديل بياناتك بنجاح',
        );
      },
    );
  }
}
