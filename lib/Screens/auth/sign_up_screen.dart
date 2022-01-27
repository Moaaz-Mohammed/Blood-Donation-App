import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../Styles/CustomColors.dart';
import '../../UsableWidgets/custom_button.dart';
import '../../UsableWidgets/custom_sized_box_height.dart';
import '../../model/user_model.dart';
import '../../services/auth.dart';
import '../../services/store.dart';
import '../../shared/Constants.dart';
import '../../shared/Functions.dart';
import '../../state_management/provider/model_hud.dart';
import '../home/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FirebaseFirestore Firebase = FirebaseFirestore.instance;
  final Auth _auth = Auth();
  final Store _store = Store();
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading1,
        child: Scaffold(
          appBar: AppBar(
            title: Text('تسجيل حساب جديد'),
          ),
          body: Form(
            key: _globalKey,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: Constants.primaryPadding,
              child: Column(
                children: [
                  CustomSizedBoxHeight(),
                  Container(
                    width: width * 0.35,
                    height: width * 0.35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: CustomColors.primaryRedColor,
                        width: 2,
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
                  CustomSizedBoxHeight(),
                  CustomSizedBoxHeight(),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'الاسم'
                    ),
                    controller: userNameController,
                    keyboardType: TextInputType.text,
                  ),
                  CustomSizedBoxHeight(),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'البريد الاكتروني',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: userEmailController,
                  ),
                  CustomSizedBoxHeight(),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'كلمة المرور',
                    ),
                    controller: userPasswordController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  CustomSizedBoxHeight(),

                  CustomSizedBoxHeight(),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'رقم الهاتف',
                    ),
                    keyboardType: TextInputType.number,
                    controller: userPhoneController,
                  ),
                  CustomSizedBoxHeight(),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'العنوان',
                    ),
                    controller: userLocationController,
                  ),
                  CustomSizedBoxHeight(),
                  CustomButton(
                    title: 'التسجيل',
                    onTap: () async {
                      if (_globalKey.currentState!.validate()) {
                        Functions.dialogLoading(
                          context: context,
                          title: 'جاري تسجيل حساب جديد',
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
                                    userLocation: userLocationController.text,
                                    userDateofBirth: userDateofBirthController.text,
                                  ),
                                )
                                    .then(
                                  (value) {
                                    Functions.navigatorPushAndRemove(
                                      context: context,
                                      screen: HomeScreen(),
                                    );
                                    Functions.showToastMsg(
                                      title: 'تم انشاء الحساب',
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
      ),
    );
  }
}
