import 'package:blood_donation/Screens/auth/sign_up_screen.dart';
import 'package:blood_donation/state_management/bloc/Cubit.dart';
import 'package:blood_donation/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../Styles/CustomColors.dart';
import '../../UsableWidgets/custom_button.dart';
import '../../UsableWidgets/custom_sized_box_height.dart';
import '../../services/auth.dart';
import '../../shared/Functions.dart';
import '../../shared/Images.dart';
import '../../shared/constants.dart';

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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: Constants.primaryPadding,
            child: Form(
              key: _globalKey,
              child: Column(
                children: [
                  SizedBox(
                    width: width * 0.5,
                    child: ClipRRect(
                      borderRadius: Constants.primaryBorderRadius,
                      child: Image.asset(
                        Images.logoImage,
                      ),
                    ),
                  ),
                  const CustomSizedBoxHeight(),
                  const CustomSizedBoxHeight(),
                  const CustomSizedBoxHeight(),
                  TextFormField(
                    style: Theme.of(context).textTheme.headline3,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail),
                      labelText: LocaleKeys.email.tr(),
                    ),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const CustomSizedBoxHeight(),
                  TextFormField(
                    style: Theme.of(context).textTheme.displayMedium,
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
                        child: Icon(AppCubit.get(context).isVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: AppCubit.get(context).isVisible,
                  ),
                  const CustomSizedBoxHeight(),
                  const CustomSizedBoxHeight(),
                  const CustomSizedBoxHeight(),
                  const CustomSizedBoxHeight(),
                  const CustomSizedBoxHeight(),
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
                  CustomButton(
                    title: LocaleKeys.register.tr(),
                    onTap: () {
                      Functions.navigatorPush(
                        context: context,
                        screen: const SignUpScreen(),
                      );
                    },
                    titleColor: CustomColors.primaryRedColor,
                    backgroundColor: CustomColors.primaryWhiteColor,
                    borderColor: CustomColors.primaryRedColor,
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
