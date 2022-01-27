import 'package:blood_donation/shared/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                    title: Text('فصائل الدم'),
                    centerTitle: true,
                    leading: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Image.asset(Constants.BloodTypesImage),
                    ),
                  ),
    );
  }
}
