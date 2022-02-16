import 'package:blood_donation/UsableWidgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Styles/CustomColors.dart';
import '../../Styles/Strings.dart';
import '../../translations/locale_keys.g.dart';

class NeedDonationBody extends StatelessWidget {
  const NeedDonationBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection(Strings.patientsCollection)
        .where(Strings.userBloodType)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return ExpansionTile(
                backgroundColor: CustomColors.primaryGreyColor,
                title: Text(
                  data[Strings.patientName],
                  style: Theme.of(context).textTheme.headline2,
                ),
                trailing: Text(
                  data[Strings.patientPhone],
                  style: Theme.of(context).textTheme.headline2,
                ),
                children: [
                  //Address
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: CustomColors.primaryRedColor),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(data[Strings.patientAddress],
                          style: Theme.of(context).textTheme.headline2),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  //Blood Type
                  Row(
                    children: [
                      const Icon(
                        Icons.bloodtype,
                        color: CustomColors.primaryRedColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(data[Strings.patientBloodType],
                          style: Theme.of(context).textTheme.headline2),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  //Contact
                  Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        color: CustomColors.primaryRedColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                          '${data[Strings.patientPhone]} - ${data[Strings.patientAnotherPhone]}',
                          style: Theme.of(context).textTheme.headline2),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  //Patient Age
                  Row(
                    children: [
                      const Icon(
                        Icons.cake,
                        color: CustomColors.primaryRedColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(data[Strings.patientAge],
                          style: Theme.of(context).textTheme.headline2),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  // Status of the patient
                  Column(
                    children: [
                      Text(LocaleKeys.status.tr(),
                          style: Theme.of(context).textTheme.headline3),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 350,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            data[Strings.patientStatus],
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                ?.copyWith(color: CustomColors.primaryRedColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }).toList(),
          );
        });
  }
}
