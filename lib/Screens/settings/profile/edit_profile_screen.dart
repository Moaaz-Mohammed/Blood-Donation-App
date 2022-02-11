import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Styles/CustomColors.dart';
import '../../../UsableWidgets/custom_button.dart';
import '../../../UsableWidgets/custom_sized_box_height.dart';
import '../../../services/store.dart';
import '../../../shared/Constants.dart';
import '../../../shared/Functions.dart';
import '../../../translations/locale_keys.g.dart';
import '../../home/home_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    Key? key,
    required this.userData,
  });

  final userData;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userAgeController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userLocationController = TextEditingController();
  var userImageUrl;

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data();
  }

  void data() {
    userNameController.text = widget.userData[Constants.userName];
    userAgeController.text = widget.userData[Constants.userDateofBirth];
    userPhoneController.text = widget.userData[Constants.userPhone];
    userLocationController.text = widget.userData[Constants.userAddress];
  }

  Store _store = Store();
  var _image;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.edit_profile.tr(),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: Constants.primaryPadding,
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              CustomSizedBoxHeight(),
              Container(
                width: width * 0.5,
                height: width * 0.5,
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
                        backgroundImage:
                            widget.userData[Constants.userImageUrl] != null &&
                                    _image == null
                                ? NetworkImage(
                                    widget.userData[Constants.userImageUrl],
                                  )
                                : widget.userData[Constants.userImageUrl] !=
                                            null &&
                                        _image != null
                                    ? FileImage(
                                        _image,
                                      )
                                    : widget.userData[Constants.userImageUrl] ==
                                                null &&
                                            _image != null
                                        ? FileImage(
                                            _image,
                                          )
                                        : AssetImage(
                                            Constants.addUserImage,
                                          ) as ImageProvider,
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
                          backgroundColor:
                              CustomColors.primaryRedColor.withOpacity(0.7),
                          child: Icon(
                            Icons.edit,
                            color: CustomColors.primaryWhiteColor,
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
                  hintText: LocaleKeys.name.tr(),
                ),
                controller: userNameController,
              ),
              CustomSizedBoxHeight(),
              TextFormField(
                decoration: InputDecoration(
                  hintText: LocaleKeys.date_of_birth.tr(),
                ),
                controller: userAgeController,
                keyboardType: TextInputType.number,
              ),
              CustomSizedBoxHeight(),
              TextFormField(
                decoration: InputDecoration(
                  hintText: LocaleKeys.phone.tr(),
                ),
                controller: userPhoneController,
                keyboardType: TextInputType.number,
              ),
              CustomSizedBoxHeight(),
              TextFormField(
                decoration: InputDecoration(
                  hintText: LocaleKeys.address.tr(),
                ),
                controller: userLocationController,
              ),
              CustomSizedBoxHeight(),
              CustomSizedBoxHeight(),
              CustomButton(
                title: LocaleKeys.save_changes.tr(),
                onTap: () async {
                  if (_globalKey.currentState!.validate()) {
                    if (userNameController.text ==
                            widget.userData[Constants.userName] &&
                        userPhoneController.text ==
                            widget.userData[Constants.userPhone] &&
                        userAgeController.text ==
                            widget.userData[Constants.userDateofBirth] &&
                        userLocationController.text ==
                            widget.userData[Constants.userAddress] &&
                        _image == null) {
                      Functions.navigatorPushAndRemove(
                        context: context,
                        screen: HomeScreen(),
                      );
                    } else {
                      Functions.dialogLoading(
                        context: context,
                        title: LocaleKeys.saving_changes.tr(),
                      );
                      if (_image != null) {
                        uploadFile().then(
                          (value) {
                            _store.editUserProfile(
                              context: context,
                              userId: widget.userData[Constants.userId],
                              userName: userNameController.text,
                              userLocation: userLocationController.text,
                              userDateofBirth: userAgeController.text,
                              userPhone: userPhoneController.text,
                            );
                          },
                        );
                      } else {
                        _store.editUserProfile(
                          context: context,
                          userPhone: userPhoneController.text,
                          userId: widget.userData[Constants.userId],
                          userName: userNameController.text,
                          userLocation: userLocationController.text,
                          userDateofBirth: userAgeController.text,
                        );
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  /// method upload photo to firebase
  Future uploadFile() async {
    if (_image != null) {
      final feedStorage = FirebaseStorage.instanceFor();
      Reference refFeedBucket = feedStorage
          .ref()
          .child('UsersProfile')
          .child('${userNameController.text}.png');
      String downloadUrl = '';
      TaskSnapshot uploadedFile = await refFeedBucket.putFile(_image);
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
}
