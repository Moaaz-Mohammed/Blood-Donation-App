import 'package:blood_donation/shared/Constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../translations/locale_keys.g.dart';

class BloodTypes extends StatefulWidget {
  const BloodTypes({Key? key}) : super(key: key);
  @override
  _BloodTypesState createState() => _BloodTypesState();
}

class _BloodTypesState extends State<BloodTypes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(LocaleKeys.blood_types.tr()),
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(Constants.BloodTypesImage),
        ),
      ),
    );
  }
}
