import 'package:blood_donation/Modules/patient_page.dart';
import 'package:blood_donation/shared/components.dart';
import 'package:flutter/material.dart';

class PatientButton extends StatelessWidget {
  const PatientButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.07,
      width: width * 0.7,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Patient()));
        },
        child: Text(
          'مـريـض',
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }
}
