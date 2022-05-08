import 'package:blood_donation/screens/patient_page.dart';
import 'package:blood_donation/shared/constants.dart';
import 'package:blood_donation/shared/functions.dart';
import 'package:blood_donation/styles/custom_colors.dart';
import 'package:blood_donation/translations/locale_keys.g.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../shared/strings.dart';

class NeedDonation extends StatefulWidget {
  const NeedDonation({Key? key}) : super(key: key);

  @override
  _NeedDonationState createState() => _NeedDonationState();
}

class _NeedDonationState extends State<NeedDonation> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection(Strings.patientsCollection)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.need_donation.tr()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: height * 0.9,
            child: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,
              ) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView(
                  children: snapshot.data!.docs.map(
                    (DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Name
                                ListTile(
                                  leading: Icon(
                                    Icons.person,
                                    color: CustomColors.primaryRedColor,
                                  ),
                                  title: Text(
                                    LocaleKeys.patient_name.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                            color:
                                                CustomColors.primaryRedColor),
                                  ),
                                  subtitle: Text(
                                    data[Strings.patientName],
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                ),
                                //Blood type
                                ListTile(
                                  leading: Icon(
                                    Icons.bloodtype,
                                    color: CustomColors.primaryRedColor,
                                  ),
                                  title: Text(
                                    LocaleKeys.blood_type.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                            color:
                                                CustomColors.primaryRedColor),
                                  ),
                                  subtitle: Text(
                                    data[Strings.patientBloodType],
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                ),
                                // Status of the patient
                                Column(
                                  children: [
                                    Text(LocaleKeys.status.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 60,
                                      decoration: Constants
                                          .primaryBoxDecorationContainer,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          data[Strings.patientStatus],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2
                                              ?.copyWith(
                                                color: CustomColors
                                                    .primaryRedColor,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  //Name
                                                  ListTile(
                                                    leading: Icon(
                                                      Icons.person,
                                                      color: CustomColors
                                                          .primaryRedColor,
                                                    ),
                                                    title: Text(
                                                      LocaleKeys.patient_name
                                                          .tr(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1
                                                          ?.copyWith(
                                                              color: CustomColors
                                                                  .primaryRedColor),
                                                    ),
                                                    subtitle: Text(
                                                      data[Strings.patientName],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2,
                                                    ),
                                                  ),
                                                  //Address
                                                  ListTile(
                                                    leading: Icon(
                                                      Icons.location_on,
                                                      color: CustomColors
                                                          .primaryRedColor,
                                                    ),
                                                    title: Text(
                                                      LocaleKeys.hospital.tr(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1
                                                          ?.copyWith(
                                                              color: CustomColors
                                                                  .primaryRedColor),
                                                    ),
                                                    subtitle: Text(
                                                      data[Strings
                                                          .patientAddress],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2,
                                                    ),
                                                  ),
                                                  //Blood type
                                                  ListTile(
                                                    leading: Icon(
                                                      Icons.bloodtype,
                                                      color: CustomColors
                                                          .primaryRedColor,
                                                    ),
                                                    title: Text(
                                                      LocaleKeys.blood_type
                                                          .tr(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1
                                                          ?.copyWith(
                                                              color: CustomColors
                                                                  .primaryRedColor),
                                                    ),
                                                    subtitle: Text(
                                                      data[Strings
                                                          .patientBloodType],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2,
                                                    ),
                                                  ),
                                                  //Contact
                                                  ListTile(
                                                    leading: Icon(
                                                      Icons.phone,
                                                      color: CustomColors
                                                          .primaryRedColor,
                                                    ),
                                                    title: Text(
                                                      LocaleKeys.phone.tr(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1
                                                          ?.copyWith(
                                                              color: CustomColors
                                                                  .primaryRedColor),
                                                    ),
                                                    subtitle: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          data[Strings
                                                              .patientPhone],
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline2,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          data[Strings
                                                              .patientAnotherPhone],
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline2,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  //Patient age
                                                  ListTile(
                                                    leading: Icon(
                                                      Icons.cake,
                                                      color: CustomColors
                                                          .primaryRedColor,
                                                    ),
                                                    title: Text(
                                                      LocaleKeys.age.tr(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1
                                                          ?.copyWith(
                                                              color: CustomColors
                                                                  .primaryRedColor),
                                                    ),
                                                    subtitle: Text(
                                                      data[Strings.patientAge],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2,
                                                    ),
                                                  ),
                                                  //Blood needed
                                                  ListTile(
                                                    leading: Icon(
                                                      Icons.vaccines,
                                                      color: CustomColors
                                                          .primaryRedColor,
                                                    ),
                                                    title: Text(
                                                      LocaleKeys.needed_blood
                                                          .tr(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1
                                                          ?.copyWith(
                                                              color: CustomColors
                                                                  .primaryRedColor),
                                                    ),
                                                    subtitle: Text(
                                                      data[Strings
                                                          .patientNeededBlood],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2,
                                                    ),
                                                  ),
                                                  // Status of the patient
                                                  Column(
                                                    children: [
                                                      Text(
                                                          LocaleKeys.status
                                                              .tr(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline5),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[100],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Text(
                                                            data[Strings
                                                                .patientStatus],
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline2
                                                                ?.copyWith(
                                                                  color: CustomColors
                                                                      .primaryRedColor,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: Text(
                                      LocaleKeys.view_more.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.copyWith(
                                            color: CustomColors.primaryRedColor,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Functions.navigatorPush(
            context: context,
            screen: const Patient(),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
