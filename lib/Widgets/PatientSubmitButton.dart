import 'package:blood_donation/Home.dart';
import 'package:blood_donation/shared/Constants.dart';
import 'package:blood_donation/shared/Controllers.dart';
import 'package:blood_donation/shared/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PatientSubmitButton extends StatelessWidget {
  const PatientSubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var BloodType;
    var formKey = GlobalKey<FormState>();
    return Container(
      height: 60,
      width: 300,
      decoration: BoxDecoration(
        color: Constants.redColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: (){
          if (formKey.currentState!.validate()) {
            final firestoreInstance =
                FirebaseFirestore.instance;
            firestoreInstance.collection("Patient").add({
              "name": nameController.text,
              "status": statusController.text,
              "phone": phoneController.text,
              "another_phone": anotherphoneController.text,
              "blood_type": BloodType.toString(),
              "age": ageController.text,
              "hospital": hospitalController.text,
              "blood_needed": bloodamountController.text,
              "registered_time": DateTime.now().toLocal(),
            }).then(
                  (value) => showDialog(
                  context: context,
                  builder: (context) => CustomDialog(
                    image: Image.network('https://media.tenor.com/images/2525ba72ea472c55bf8b2153e9ea9f11/tenor.gif'),
                    title: 'تم إرسال البيانات بنجاح',
                    description1:
                    'تم إرسال البيانات وسيتم التواصل معك في أقرب فرصة',
                    description2: '',
                  )).then((value) =>
                  navigateTo(context, home_page())),
            );
          };
        },
        child: Text(
          'إرسـال البيـانـات',
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }
}
