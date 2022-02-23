import 'package:blood_donation/screens/auth/log_in_screen.dart';
import 'package:blood_donation/shared/constants.dart';
import 'package:blood_donation/shared/functions.dart';
import 'package:blood_donation/shared/images.dart';
import 'package:blood_donation/styles/custom_colors.dart';
import 'package:blood_donation/translations/locale_keys.g.dart';
import 'package:blood_donation/usable_widgets/custom_button.dart';
import 'package:blood_donation/usable_widgets/custom_sized_box_height.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../state_management/bloc/cubit.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.reset_password.tr()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: Constants.primaryPadding,
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  Images.resetPasswordImage,
                  width: width * 0.6,
                ),
                const CustomSizedBoxHeight(),
                const CustomSizedBoxHeight(),
                Text(
                  LocaleKeys.reset_password.tr(),
                  style: Theme.of(context).textTheme.headline3,
                ),
                const CustomSizedBoxHeight(),
                Text(
                  LocaleKeys.reset_password_content.tr(),
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: AppCubit.get(context).isDark
                            ? CustomColors.primaryRedColor
                            : CustomColors.primaryDarkColor.withOpacity(0.5),
                      ),
                ),
                const CustomSizedBoxHeight(),
                const CustomSizedBoxHeight(),
                const CustomSizedBoxHeight(),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.email.tr(),
                  ),
                ),
                SizedBox(
                  height: height * 0.2,
                ),
                CustomButton(
                    onTap: () async {
                      try {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(
                                email: emailController.text.trim())
                            .then((value) {
                          Functions.showToastMsg(
                            title: LocaleKeys.sent.tr(),
                          ).then((value) {
                            Functions.showToastMsg(
                              title: LocaleKeys.check_your_email.tr(),
                            );
                          }).then((value) {
                            Functions.navigatorPush(
                              context: context,
                              screen: const LogInScreen(),
                            );
                          });
                        });
                      } on FirebaseAuthException catch (error) {
                        Functions.showToastMsg(title: error.toString());
                      }
                    },
                    title: LocaleKeys.reset_password.tr())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
