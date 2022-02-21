import 'package:blood_donation/shared/functions.dart';
import 'package:blood_donation/shared/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../Styles/custom_colors.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../../usable_widgets/custom_button.dart';
import '../../new_home_screen.dart';

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
        title: Text(LocaleKeys.send_message.tr()),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Name
                  TextFormField(
                    controller: senderController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: CustomColors.primaryRedColor),
                    decoration: InputDecoration(
                      labelText: LocaleKeys.sender.tr(),
                      labelStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: CustomColors.primaryRedColor,
                      ),
                      border: const OutlineInputBorder(),
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
                    decoration: InputDecoration(
                      labelText: LocaleKeys.phone.tr(),
                      labelStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: CustomColors.primaryRedColor,
                      ),
                      border: const OutlineInputBorder(),
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
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.your_message.tr(),
                      labelStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(
                        Icons.message,
                        color: CustomColors.primaryRedColor,
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  //Submit Button
                  CustomButton(
                    onTap: () {
                      final firestore = FirebaseFirestore.instance;
                      firestore.collection(Strings.mailCollection).add({
                        Strings.mailSender: senderController.text,
                        Strings.mailContent: messageController.text,
                        Strings.mailSenderPhone: phoneController.text,
                        Strings.mailTime: DateTime.now().toLocal(),
                      }).then(
                        (value) =>
                            Functions.showToastMsg(title: LocaleKeys.sent.tr())
                                .then(
                          (value) => Functions.navigatorPush(
                            context: context,
                            screen: const NewHomeScreen(),
                          ),
                        ),
                      );
                    },
                    title: LocaleKeys.submit.tr(),
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
