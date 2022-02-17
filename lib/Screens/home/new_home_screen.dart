import 'package:blood_donation/Screens/find_donors/find_donors_screen.dart';
import 'package:blood_donation/Screens/home/home_category_card.dart';
import 'package:blood_donation/Screens/settings/profile/profile_screen.dart';
import 'package:blood_donation/Screens/settings/settings.dart';
import 'package:blood_donation/UsableWidgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Styles/CustomColors.dart';
import '../../Styles/Images.dart';
import '../../Styles/Strings.dart';
import '../../shared/Functions.dart';
import '../../translations/locale_keys.g.dart';
import 'drawer/drawer.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({Key? key}) : super(key: key);

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  String uid = '';

  Map<String, dynamic>? userData;

  @override
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
    var mapUrl =
        'https://www.google.com/maps/search/hospital/@30.7540542,30.3489529,8.29z';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.home.tr(),
        ),
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${LocaleKeys.hello.tr()}${userData![Strings.userName]}',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                LocaleKeys.hru.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                onTap: () {
                                  Functions.navigatorPush(
                                    context: context,
                                    screen: const FindDonorsScreen(),
                                  );
                                },
                                child: HomeCategoryCard(
                                  image: Images.bloodDropImage,
                                  backgroundColor: CustomColors.primaryRedColor,
                                  title: LocaleKeys.find_donors.tr(),
                                  content: LocaleKeys.sub_find_donors.tr(),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Functions.navigatorPush(
                                    context: context,
                                    screen: ProfileScreen(userData: userData),
                                  );
                                },
                                child: HomeCategoryCard(
                                  image: Images.profileImage,
                                  backgroundColor: Colors.blue.withOpacity(0.7),
                                  content: LocaleKeys.view_profile.tr(),
                                  title: LocaleKeys.profile.tr(),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (await canLaunch(mapUrl)) {
                                    await launch(mapUrl);
                                  } else {
                                    throw 'could not open $mapUrl';
                                  }
                                },
                                child: HomeCategoryCard(
                                  image: Images.hospitalImage,
                                  backgroundColor:
                                      CustomColors.primaryGreenColor,
                                  title: LocaleKeys.find_hospital.tr(),
                                  content: LocaleKeys.sub_find_hospital.tr(),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Functions.navigatorPush(
                                    context: context,
                                    screen: SettingsScreen(userData: userData),
                                  );
                                },
                                child: HomeCategoryCard(
                                  image: Images.settingsImage,
                                  backgroundColor:
                                      CustomColors.primaryDarkColor,
                                  title: LocaleKeys.settings.tr(),
                                  content: LocaleKeys.control_app.tr(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
