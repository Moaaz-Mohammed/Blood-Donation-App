import 'package:blood_donation/shared/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Styles/CustomColors.dart';
import 'home/home_screen.dart';

class Mail extends StatefulWidget {
  const Mail({Key? key}) : super(key: key);

  @override
  _MailState createState() => _MailState();
}

class _MailState extends State<Mail> {
  var formKey = GlobalKey<FormState>();
  TextEditingController senderController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(text: 'إرسال رساله'),
        centerTitle: true,
        leading: const Text(''),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_forward_ios,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Divider(
                        thickness: 1,
                      ),
                      const Text(
                        'يسعدنا إستفسارك وتواصلك معنا 😍',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        color: CustomColors.primaryRedColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //Name
                  TextFormField(
                    cursorColor: CustomColors.primaryRedColor,
                    controller: senderController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: CustomColors.primaryRedColor),
                    decoration: const InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'الراسـل',
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.person,
                        color: CustomColors.primaryRedColor,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Status
                  TextFormField(
                    cursorColor: CustomColors.primaryRedColor,
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(color: CustomColors.primaryRedColor),
                    decoration: const InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'رقم الهاتف',
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: CustomColors.primaryRedColor,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Status
                  TextFormField(
                    cursorColor: CustomColors.primaryRedColor,
                    controller: messageController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: CustomColors.primaryRedColor),
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'رسـالتك',
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.message,
                        color: CustomColors.primaryRedColor,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  //Submit Button
                  Container(
                    height: 60,
                    width: 300,
                    decoration: BoxDecoration(
                      color: CustomColors.primaryRedColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () {
                        final firestoreInstance = FirebaseFirestore.instance;
                        firestoreInstance.collection("Mail").add({
                          "sender": senderController.text,
                          "message": messageController.text,
                          "phone": phoneController.text,
                          "date": DateTime.now().toLocal(),
                        }).then(
                          (value) => showDialog(
                              context: context,
                              builder: (context) => CustomDialog(
                                    image: Image.network(
                                        'https://media.tenor.com/images/2525ba72ea472c55bf8b2153e9ea9f11/tenor.gif'),
                                    title: 'تم إرسال رسالتك',
                                    description1:
                                        'تم إرسال رسالتك بنجاح وسيتم التواصل معك بكل سرور',
                                    description2: '',
                                  )).then((value) =>
                              navigateTo(context, const HomeScreen())),
                        );
                      },
                      child: const Text(
                        'إرســــال',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
