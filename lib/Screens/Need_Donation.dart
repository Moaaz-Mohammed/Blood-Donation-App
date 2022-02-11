import 'package:blood_donation/Screens/patient_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../shared/Functions.dart';
import '../translations/locale_keys.g.dart';

class Need_Donation extends StatefulWidget {
  const Need_Donation({Key? key}) : super(key: key);

  @override
  _Need_DonationState createState() => _Need_DonationState();
}

class _Need_DonationState extends State<Need_Donation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Patient').snapshots();
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
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView(
                    children: snapshot.data!.docs.map(
                  (DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        child: ListTile(
                          title: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Name
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(data['name'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2),
                                  ],
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                //Address
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(data['hospital']),
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
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(data['blood_type']),
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
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(data['phone']),
                                  ],
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                //Patient Age
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(data['age']),
                                  ],
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                // Status of the patient
                                Column(
                                  children: [
                                    Text(LocaleKeys.status.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 350,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(data['status']),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ).toList());
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Functions.navigatorPush(
            context: context,
            screen: Patient(),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
