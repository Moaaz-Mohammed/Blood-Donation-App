import 'package:blood_donation/UsableWidgets/loading.dart';
import 'package:blood_donation/shared/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Styles/CustomColors.dart';
import '../../translations/locale_keys.g.dart';

class NeedDonationBody extends StatelessWidget {
  const NeedDonationBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('Patient')
        .where(Constants.userBloodType)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return ExpansionTile(
                backgroundColor: CustomColors.primaryGreyColor,
                title: Text(
                  data['name'],
                  style: Theme.of(context).textTheme.headline2,
                ),
                trailing: Text(
                  data['phone'],
                  style: Theme.of(context).textTheme.headline2,
                ),
                children: [
                  //Address
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          color: CustomColors.primaryRedColor),
                      SizedBox(
                        width: 10,
                      ),
                      Text(data['hospital'],
                          style: Theme.of(context).textTheme.headline2),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  //Blood Type
                  Row(
                    children: [
                      Icon(
                        Icons.bloodtype,
                        color: CustomColors.primaryRedColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(data['blood_type'],
                          style: Theme.of(context).textTheme.headline2),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  //Contact
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: CustomColors.primaryRedColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('${data['phone']} - ${data['another_phone']}',
                          style: Theme.of(context).textTheme.headline2),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  //Patient Age
                  Row(
                    children: [
                      Icon(
                        Icons.cake,
                        color: CustomColors.primaryRedColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(data['age'],
                          style: Theme.of(context).textTheme.headline2),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  // Status of the patient
                  Column(
                    children: [
                      Text(LocaleKeys.status.tr(),
                          style: Theme.of(context).textTheme.headline3),
                      SizedBox(
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
                            data['status'],
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
