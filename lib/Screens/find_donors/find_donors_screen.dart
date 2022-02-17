import 'package:blood_donation/shared/constants.dart';
import 'package:blood_donation/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FindDonorsScreen extends StatefulWidget {
  const FindDonorsScreen({Key? key}) : super(key: key);

  @override
  _FindDonorsScreenState createState() => _FindDonorsScreenState();
}

class _FindDonorsScreenState extends State<FindDonorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.find_donors.tr()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: Constants.primaryPadding,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: LocaleKeys.search_for_donor.tr(),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
