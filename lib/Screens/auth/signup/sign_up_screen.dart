import 'dart:io';

import 'package:blood_donation/shared/Controllers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../Styles/CustomColors.dart';
import '../../../UsableWidgets/custom_button.dart';
import '../../../model/user_model.dart';
import '../../../services/auth.dart';
import '../../../services/store.dart';
import '../../../shared/Constants.dart';
import '../../../shared/Functions.dart';
import '../../../state_management/bloc/Cubit.dart';
import '../../../state_management/provider/model_hud.dart';
import '../../../translations/locale_keys.g.dart';
import '../../home/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final Auth _auth = Auth();
  final Store _store = Store();
  var BloodType;
  var Status;
  var ShareData;
  File? _image;
  var userImageUrl;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userDateofBirthController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userLocationController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  _imgFromGallery() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(
      () {
        _image = File(image!.path);
      },
    );
  }

  Future uploadFile() async {
    if (_image != null) {
      final feedStorage = FirebaseStorage.instanceFor();
      Reference refFeedBucket = feedStorage
          .ref()
          .child('UsersProfile')
          .child('${userNameController.text}.png');
      String downloadUrl = '';
      TaskSnapshot uploadedFile = await refFeedBucket.putFile(_image!);
      if (uploadedFile.state == TaskState.success) {
        downloadUrl = await refFeedBucket.getDownloadURL();
        setState(
          () {
            userImageUrl = downloadUrl;
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    DateTime _dateTime = DateTime.now();
    double height = MediaQuery.of(context).size.height;
    var dateController = DateFormat.yMMMd().format(_dateTime);
    return ModalProgressHUD(
      inAsyncCall: Provider.of<ModelHud>(context).isLoading1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.register.tr()),
        ),
        body: Form(
          key: _globalKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: Constants.primaryPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image
                Center(
                  child: Container(
                    width: width * 0.25,
                    height: width * 0.25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: CustomColors.primaryRedColor,
                        width: 1,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundColor: CustomColors.primaryWhiteColor,
                            radius: double.infinity,
                            backgroundImage: _image == null
                                ? AssetImage(
                                    Constants.addUserImage,
                                  ) as ImageProvider
                                : FileImage(
                                    _image!,
                                  ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () {
                              _imgFromGallery();
                            },
                            borderRadius: BorderRadius.circular(50.0),
                            child: CircleAvatar(
                              radius: width * 0.04,
                              backgroundColor: CustomColors.primaryWhiteColor,
                              child: Icon(
                                Icons.add_a_photo_rounded,
                                color: CustomColors.primaryRedColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Name
                TextFormField(
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: CustomColors.primaryRedColor,
                      ),
                  decoration: InputDecoration(
                    labelText: LocaleKeys.name.tr(),
                  ),
                  controller: userNameController,
                  keyboardType: TextInputType.text,
                ),
                // E-Mail
                TextFormField(
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: CustomColors.primaryRedColor,
                      ),
                  decoration: InputDecoration(
                    labelText: LocaleKeys.email.tr(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: userEmailController,
                ),
                // Password
                TextFormField(
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: CustomColors.primaryRedColor,
                      ),
                  decoration: InputDecoration(
                    labelText: LocaleKeys.password.tr(),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          AppCubit.get(context).isVisible =
                              !AppCubit.get(context).isVisible;
                        });
                      },
                      child: Icon(AppCubit.get(context).isVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  controller: userPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: AppCubit.get(context).isVisible,
                ),
                // Do You Suffer any Diseases?
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.do_u_suffer.tr(),
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                              color: CustomColors.primaryRedColor,
                            ),
                      ),
                      DropdownButton(
                        alignment: Alignment.center,
                        dropdownColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        iconSize: 25,
                        iconEnabledColor: CustomColors.primaryRedColor,
                        value: Status,
                        hint: Text(
                          LocaleKeys.choose.tr(),
                          style: TextStyle(color: Colors.grey),
                        ),
                        items: [
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                LocaleKeys.no_chronic_diseases.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryRedColor,
                                    ),
                              ),
                            ),
                            value: LocaleKeys.no_chronic_diseases.tr(),
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                LocaleKeys.anemia_diseases.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryRedColor,
                                    ),
                              ),
                            ),
                            value: LocaleKeys.anemia_diseases.tr(),
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                LocaleKeys.genetic_blood_diseases.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryRedColor,
                                    ),
                              ),
                            ),
                            value: LocaleKeys.genetic_blood_diseases.tr(),
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                LocaleKeys.hepatitis.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryRedColor,
                                    ),
                              ),
                            ),
                            value: LocaleKeys.hepatitis.tr(),
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                LocaleKeys.aids.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryRedColor,
                                    ),
                              ),
                            ),
                            value: LocaleKeys.aids.tr(),
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                LocaleKeys.cancer.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryRedColor,
                                    ),
                              ),
                            ),
                            value: LocaleKeys.cancer.tr(),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            Status = value;
                          });
                        },
                      )
                    ],
                  ),
                ),
                // Blood Types
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Row(
                    children: [
                      Text(
                        LocaleKeys.blood_types.tr(),
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                              color: CustomColors.primaryRedColor,
                            ),
                      ),
                      SizedBox(width: width * 0.15),
                      DropdownButton(
                        dropdownColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        alignment: Alignment.center,
                        iconSize: 30,
                        iconEnabledColor: CustomColors.primaryRedColor,
                        value: BloodType,
                        hint: Text(
                          LocaleKeys.choose_blood_type.tr(),
                          style: TextStyle(color: Colors.grey),
                        ),
                        items: [
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                "+O",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryRedColor,
                                    ),
                              ),
                            ),
                            value: '+O',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                '-O',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryRedColor,
                                    ),
                              ),
                            ),
                            value: '-O',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                "+A",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryRedColor,
                                    ),
                              ),
                            ),
                            value: '+A',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                "-A",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryRedColor,
                                    ),
                              ),
                            ),
                            value: '-A',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                "+B",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryRedColor,
                                    ),
                              ),
                            ),
                            value: '+B',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                "-B",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryRedColor,
                                    ),
                              ),
                            ),
                            value: '-B',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                "+AB",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryRedColor,
                                    ),
                              ),
                            ),
                            value: '+AB',
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                "-AB",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: CustomColors.primaryRedColor,
                                    ),
                              ),
                            ),
                            value: '-AB',
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            BloodType = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // Phone
                TextFormField(
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: CustomColors.primaryRedColor,
                      ),
                  decoration: InputDecoration(
                    labelText: LocaleKeys.phone.tr(),
                  ),
                  keyboardType: TextInputType.number,
                  controller: userPhoneController,
                ),
                // Date of Birth
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.date_of_birth.tr(),
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                              color: CustomColors.primaryRedColor,
                            ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          width: width * 0.8,
                          height: height * 0.1,
                          child: CupertinoDatePicker(
                            initialDateTime: _dateTime,
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (value) {
                              var date = DateFormat.yMMMd().format(value);
                              setState(
                                () {
                                  dateController = date;
                                },
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Last Donation Date
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.last_donation_date.tr(),
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                              color: CustomColors.primaryRedColor,
                            ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          width: width * 0.8,
                          height: height * 0.1,
                          child: CupertinoDatePicker(
                            initialDateTime: _dateTime,
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (value) {
                              var date = DateFormat.yMMMd().format(value);
                              setState(
                                () {
                                  dateController = date;
                                },
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Address
                TextFormField(
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: CustomColors.primaryRedColor,
                      ),
                  decoration: InputDecoration(
                    labelText: LocaleKeys.address.tr(),
                  ),
                  controller: userLocationController,
                ),
                CustomButton(
                  title: LocaleKeys.register.tr(),
                  onTap: () async {
                    if (_globalKey.currentState!.validate()) {
                      Functions.dialogLoading(
                        context: context,
                        title: LocaleKeys.registering.tr(),
                      );
                      await _auth
                          .signUpWithEmailAndPassword(
                        userEmailController.text,
                        userPasswordController.text,
                        context,
                      )
                          .then(
                        (value) {
                          User? userAuth = FirebaseAuth.instance.currentUser;
                          uploadFile().then(
                            (value) {
                              _store
                                  .addUser(
                                UserModel(
                                  userId: userAuth!.uid,
                                  userName: userNameController.text,
                                  userPhone: userPhoneController.text,
                                  userEmail: userEmailController.text,
                                  userImageUrl: userImageUrl,
                                  userAddress: userLocationController.text,
                                  userDateofBirth: dateController.toString(),
                                  userBloodType: BloodType.toString(),
                                  userStatus: Status.toString(),
                                  userLastDonation:
                                      LastDonationcontroller.toString(),
                                ),
                              )
                                  .then(
                                (value) {
                                  Functions.navigatorPushAndRemove(
                                    context: context,
                                    screen: HomeScreen(),
                                  );
                                  Functions.showToastMsg(
                                    title: LocaleKeys.registered.tr(),
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
