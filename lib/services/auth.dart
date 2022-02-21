import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Screens/auth/log_in_screen.dart';
import '../Screens/home/new_home_screen.dart';
import '../shared/functions.dart';
import '../translations/locale_keys.g.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  /// method sign up
  Future signUpWithEmailAndPassword(
    String email,
    String password,
    context,
  ) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      Functions.showToastMsg(
        title: e.message.toString(),
      );
    } catch (e) {
      Functions.showToastMsg(
        title: e.toString(),
      );
    }
  }

  /// Sign In Method
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required context,
  }) async {
    Functions.dialogLoading(
      context: context,
      title: 'جاري تسجيل الدخول',
    );
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (value) {
          Functions.navigatorPushAndRemove(
            context: context,
            screen: const NewHomeScreen(),
          );
          Functions.showToastMsg(
            title: LocaleKeys.logged_in.tr(),
          );
        },
      );
      return;
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      Functions.showToastMsg(
        title: e.message.toString(),
      );
    } catch (e) {
      Functions.showToastMsg(
        title: e.toString(),
      );
    }
  }

  Future signOut({
    required context,
  }) async {
    try {
      return await _auth.signOut().then((value) {
        Functions.navigatorPushAndRemove(
          context: context,
          screen: const LogInScreen(),
        );
        Functions.showToastMsg(
          title: LocaleKeys.logged_out.tr(),
        );
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
