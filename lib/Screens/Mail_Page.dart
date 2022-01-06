import 'package:blood_donation/shared/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blood_donation/shared/components.dart';
import 'package:flutter/material.dart';
import '../Home.dart';
import '../Styles/Themes/DarkTheme.dart';
import '../Styles/Themes/LightTheme.dart';

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
    return MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: DarkTheme,
      theme: LightTheme,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child:(
            Scaffold(
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
                      color: Constants.redColor,
                    ),
                  ),
                ],
              ),
              body:
              SingleChildScrollView(
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
                              Divider(thickness: 1,),
                              Text(
                                'يسعدنا إستفسارك وتواصلك معنا 😍',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Divider(thickness: 1,color: Constants.redColor,),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //Name
                          TextFormField(
                            cursorColor: Constants.redColor,
                            controller: senderController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Constants.redColor),
                            decoration: InputDecoration(
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
                                color: Constants.redColor,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Status
                          TextFormField(
                            cursorColor: Constants.redColor,
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(color: Constants.redColor),
                            decoration: InputDecoration(
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
                                color: Constants.redColor,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Status
                          TextFormField(
                            cursorColor: Constants.redColor,
                            controller: messageController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Constants.redColor),
                            maxLines: 3,
                            decoration: InputDecoration(
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
                                color: Constants.redColor,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          //Submit Button
                          Container(
                            height: 60,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Constants.redColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextButton(
                              onPressed: (){
                                final firestoreInstance =
                                    FirebaseFirestore.instance;
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
                                      navigateTo(context, home_page())),
                                );
                              },
                              child: Text(
                                'إرســــال',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ),
          ),
        );
      },
    );
  }
}
