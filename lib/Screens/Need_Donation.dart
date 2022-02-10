import 'package:blood_donation/Screens/patient_page.dart';
import 'package:blood_donation/shared/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../shared/Functions.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('محتاجون للتبرع'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Functions.navigatorPush(
                context: context,
                screen: Patient(),
              );
            },
            child: Text('إضافة مريض'),
          ),
          SizedBox(
            height: 500,
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
                      padding: const EdgeInsets.all(10.0),
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
                                    DetailtsText(text: data['name']),
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
                                    DetailtsText(text: data['hospital']),
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
                                    DetailtsText(text: data['blood_type']),
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
                                    DetailtsText(text: data['phone']),
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
                                    DetailtsText(text: data['age']),
                                  ],
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                // Status of the patient
                                Column(
                                  children: [
                                    Text("الحالة",
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
                                        child:
                                            DetailtsText(text: data['status']),
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
        ],
      ),
    );
  }
}
