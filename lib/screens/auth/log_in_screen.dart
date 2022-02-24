import 'package:blood_donation/Screens/auth/sign_up_screen.dart';
import 'package:blood_donation/screens/auth/reset_password.dart';
import 'package:blood_donation/state_management/bloc/cubit.dart';
import 'package:blood_donation/translations/locale_keys.g.dart';
import 'package:blood_donation/usable_widgets/custom_sized_box_width.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../Styles/custom_colors.dart';
import '../../services/auth.dart';
import '../../shared/constants.dart';
import '../../shared/functions.dart';
import '../../shared/images.dart';
import '../../usable_widgets/custom_button.dart';
import '../../usable_widgets/custom_sized_box_height.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _auth = Auth();
  bool isVisible = true;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: Constants.primaryPadding,
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Images.logoImage,
                    height: height * 0.2,
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.headline2,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail),
                      labelText: LocaleKeys.email.tr(),
                    ),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const CustomSizedBoxHeight(),
                  TextFormField(
                    style: Theme.of(context).textTheme.headline2,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      labelText: LocaleKeys.password.tr(),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            AppCubit.get(context).isVisible =
                                !AppCubit.get(context).isVisible;
                          });
                        },
                        child: Icon(
                          AppCubit.get(context).isVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: AppCubit.get(context).isVisible,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        LocaleKeys.forgot_password.tr(),
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    onTap: () {
                      Functions.navigatorPush(
                        context: context,
                        screen: const ResetPasswordScreen(),
                      );
                    },
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  CustomButton(
                    title: LocaleKeys.login.tr(),
                    onTap: () async {
                      if (_globalKey.currentState!.validate()) {
                        await _auth.signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          context: context,
                        );
                      }
                    },
                  ),
                  const CustomSizedBoxHeight(),
                  const CustomSizedBoxHeight(),
                  InkWell(
                    child: Row(
                      children: [
                        Text(
                          LocaleKeys.dont_have_acc.tr(),
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const CustomSizedBoxWidth(),
                        Text(
                          LocaleKeys.register_now.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(color: CustomColors.primaryRedColor),
                        ),
                      ],
                    ),
                    onTap: () {
                      Functions.navigatorPush(
                        context: context,
                        screen: const SignUpScreen(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
