import 'package:blood_donation/Screens/donation_history/add_new_donation.dart';
import 'package:blood_donation/Screens/donation_history/history_card.dart';
import 'package:blood_donation/shared/constants.dart';
import 'package:blood_donation/translations/locale_keys.g.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Styles/Strings.dart';
import '../../UsableWidgets/loading.dart';

class DonationsHistory extends StatelessWidget {
  const DonationsHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection(Strings.usersCollection)
        .doc(user?.uid)
        .collection(Strings.userDonationsHistoryCollection)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.history.tr()),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading();
              }
              return Padding(
                padding: Constants.primaryPadding,
                child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return HistoryCard(
                        name: data[Strings.PatientName],
                        time: data[Strings.donationTime],
                        date: data[Strings.donationDate],
                        address: data[Strings.donationAddress],
                        notes: data[Strings.donationNotes]);
                  }).toList(),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: const AddNewDonation(),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
