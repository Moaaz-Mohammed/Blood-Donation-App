import 'package:blood_donation/Styles/CustomColors.dart';
import 'package:blood_donation/state_management/bloc/Cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../Styles/Images.dart';
import '../../Styles/Strings.dart';
import '../../UsableWidgets/change_language_dialog.dart';
import '../../UsableWidgets/loading.dart';
import '../../translations/locale_keys.g.dart';
import 'Drawer.dart';
import 'need_donation_body.dart';
import 'next_donation_date.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String uid = '';
  Map<String, dynamic>? userData;

  void initState() {
    super.initState();

    /// this fuc to wait app for build and do timer to avoid un save operations
    SchedulerBinding.instance!.addPostFrameCallback(
      (_) {
        /// get user id from auth
        User? userAuth = FirebaseAuth.instance.currentUser;
        if (userAuth != null) {
          /// get user data from firebase by user id
          FirebaseFirestore.instance
              .collection(Strings.usersCollection)
              .doc(userAuth.uid)
              .get()
              .then(
            (value) {
              setState(
                () {
                  userData = value.data();
                },
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.home.tr()),
        actions: [
          IconButton(
            onPressed: () {
              change_language_dialog(context);
            },
            icon: const Icon(Icons.language),
          ),
          IconButton(
              onPressed: () {
                AppCubit.get(context).changeAppMode();
              },
              icon: Icon(AppCubit.get(context).isDark
                  ? Icons.light_mode
                  : Icons.dark_mode))
        ],
      ),
      drawer: CustomDrawer(
        userData: userData,
      ),
      body: userData == null
          ? const Loading()
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            Images.waveImage,
                            height: 50,
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    LocaleKeys.hello.tr(),
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  Text(
                                    userData![Strings.userName],
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(
                                            color:
                                                CustomColors.primaryRedColor),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                LocaleKeys.hru.tr(),
                                style: Theme.of(context).textTheme.headline2,
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Text(
                        LocaleKeys.next_donation_date.tr(),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      NextDonationDate(
                        userData: userData,
                      ),
                      SizedBox(height: height * 0.02),
                      const Divider(),
                      Text(
                        LocaleKeys.need_donation.tr(),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(
                        height: height * 0.5,
                        width: width * 0.9,
                        child: const NeedDonationBody(),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
