import 'package:blood_donation/Screens/auth/sign_up_screen.dart';
import 'package:blood_donation/state_management/bloc/Cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Styles/CustomColors.dart';
import '../../UsableWidgets/custom_button.dart';
import '../../UsableWidgets/custom_sized_box_height.dart';
import '../../services/auth.dart';
import '../../shared/Constants.dart';
import '../../shared/Functions.dart';

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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
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
                          Constants.LogoImage,
                        ),
                      ),
                    ),
                    CustomSizedBoxHeight(),
                    CustomSizedBoxHeight(),
                    CustomSizedBoxHeight(),
                    TextFormField(
                      style: Theme.of(context).textTheme.headline3,
                      decoration: InputDecoration(
                        hintText: 'البريد الإكتروني',
                      ),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    CustomSizedBoxHeight(),
                    TextFormField(
                        style: Theme.of(context).textTheme.displayMedium,
                        decoration: InputDecoration(
                          hintText: 'كلمة المرور',
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                AppCubit.get(context).isVisible = !AppCubit.get(context).isVisible;
                              });
                            },
                            child: Icon(AppCubit.get(context).isVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: AppCubit.get(context).isVisible,),
                    CustomSizedBoxHeight(),
                    CustomSizedBoxHeight(),
                    CustomSizedBoxHeight(),
                    CustomSizedBoxHeight(),
                    CustomSizedBoxHeight(),
                    CustomButton(
                      title: 'تسجيل الدخول',
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
                    CustomSizedBoxHeight(),
                    CustomButton(
                      title: 'تسجيل حساب جديد',
                      onTap: () {
                        Functions.navigatorPush(
                          context: context,
                          screen: SignUpScreen(),
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
      ),
    );
  }
}
