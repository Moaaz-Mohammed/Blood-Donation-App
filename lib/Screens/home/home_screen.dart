import 'package:blood_donation/Styles/CustomColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../UsableWidgets/Drawer.dart';
import '../../UsableWidgets/VolunteerButton.dart';
import '../../shared/Constants.dart';
import '../../translations/locale_keys.g.dart';

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
              .collection(Constants.usersCollection)
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
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.home.tr()),
      ),
      drawer: CustomDrawer(
        userData: userData,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  Constants.waveImage,
                  height: 50,
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${LocaleKeys.hello.tr()} ',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          userData == null ? '' : userData![Constants.userName],
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: CustomColors.primaryRedColor),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
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
            SizedBox(height: height * 0.02,),
            Container(
              padding: Constants.primaryPadding,
              width: double.infinity,
              decoration: BoxDecoration(
                color: CustomColors.primaryRedColor,
                borderRadius: Constants.primaryBorderRadius,
              ),
              child: Padding(
                padding: Constants.primaryPadding,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData![Constants.userLastDonation],
                              style: Theme.of(context).textTheme.headline5?.copyWith(
                                color: CustomColors.primaryWhiteColor
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.map))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            VolunteerButton(),
          ],
        ),
      ),
    );
  }
}
