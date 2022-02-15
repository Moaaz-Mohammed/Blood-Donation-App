import 'dart:async';

import 'package:blood_donation/shared/Constants.dart';
import 'package:blood_donation/shared/Functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'Screens/auth/log_in_screen.dart';
import 'Screens/home/home_screen.dart';
import 'Screens/on_boarding/on_boarding_screen.dart';
import 'Styles/CustomColors.dart';
import 'Styles/Images.dart';

class MainSlashScreen extends StatefulWidget {
  const MainSlashScreen({
    Key? key,
    required this.onBoarding,
  });

  final onBoarding;

  @override
  State<MainSlashScreen> createState() => _MainSlashScreenState();
}

class _MainSlashScreenState extends State<MainSlashScreen> {
  @override
  void initState() {
    super.initState();

    /// this fuc to wait app for build and do timer to avoid un save operations
    SchedulerBinding.instance!.addPostFrameCallback(
      (_) {
        User? userAuth = FirebaseAuth.instance.currentUser;
        Timer(
          const Duration(seconds: 3),
          () {
            Functions.navigatorPushAndRemove(
              context: context,
              screen: userAuth == null
                  ? widget.onBoarding
                      ? const LogInScreen()
                      : const OnBoardingScreen()
                  : const HomeScreen(),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CustomColors.primaryRedColor,
      body: Center(
        child: Image.asset(
          Images.LogoImage,
          width: width * 0.5,
        ),
      ),
    );
  }
}
