import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import '../Styles/custom_colors.dart';
import '../usable_widgets/custom_dialog_do_you_want.dart';
import 'constants.dart';

class Functions {
  /// method navigate page
  static void navigatorPush({context, screen}) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: screen,
      ),
    );
  }

  /// method navigate and remove page
  static void navigatorPushAndRemove({context, screen}) {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: screen,
      ),
      (route) => false,
    );
  }

  /// method show toast message
  static Future showToastMsg({
    required title,
  }) async {
    return await Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: CustomColors.primaryRedColor,
      textColor: CustomColors.primaryWhiteColor,
      fontSize: 16.0,
    );
  }

  /// dialog loading
  static void dialogLoading({
    required context,
    required title,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircularProgressIndicator(
                color: CustomColors.primaryRedColor,
              ),
              Text(
                title,
              ),
            ],
          ),
        );
      },
    );
  }

  /// dialog do you want
  static void dialogDoYouWant({
    required context,
    required title,
    required onTapYes,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogDoYouWant(
          title: title,
          onTapYes: onTapYes,
        );
      },
    );
  }

  /// dialog open photo and zoom in it
  static void dialogOpenPhotoAndZoom({
    required context,
    required image,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double height = MediaQuery.of(context).size.height;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: Constants.primaryBorderRadius,
            ),
            child: Container(
              height: height * 0.5,
              decoration: Constants.primaryBoxDecorationContainer,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: Constants.primaryBorderRadius,
                child: Image.network(
                  image,
                  height: height * 0.5,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
