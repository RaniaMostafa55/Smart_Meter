import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:Smart_Meter/pages/setting_page.dart';
import '../models/user_data_model.dart';
import '../models/user_response_model.dart';
import '../services/shared_helper.dart';
import '../services/shared_prefs.dart';
import 'package:get/get.dart';
import '../services/app_services.dart';
import '../services/translation_service.dart';

class EditProfileUI extends StatefulWidget {
  @override
  _EditProfileUIState createState() => _EditProfileUIState();
}

class _EditProfileUIState extends State<EditProfileUI> {
  final appServices = Get.find<AppServices>();
  final translationServices = Get.find<TranslationService>();
  bool load = false;
  bool isObsecurePassword = true;
  var omail = TextEditingController();
  var opass = TextEditingController();
  var nuser = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  void postData() async {
    load = true;
    try {
      var response = await Dio().post('https://rooot.azurewebsites.net/user/create',
          data: UserDataModel(
            //userId: SharedHelper.getId(),
            name: (nuser.text.isEmpty) ? SharedHelper.getUsername() : nuser.text,
          ).toJson());
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SettingPageUI()));
      load = false;
    } catch (e) {
      load = false;
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 147, 171, 1),
        title: Text('edit username'.tr,
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (contest) => SettingPageUI(),
                ),
              );
            }),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(height: 15),
              Center(
                child: Stack(
                  children: [
                    Obx(() {
                      return Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            boxShadow: [
                              BoxShadow(spreadRadius: 2, blurRadius: 10, color: Colors.black.withOpacity(0.1))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: appServices.profileImage.value.isEmpty
                                  ? AssetImage('assets/girl.png')
                                  : FileImage(
                                      File(appServices.profileImage.value),
                                    ),
                            )),
                      );
                    }),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 4, color: Colors.white), color: Color.fromRGBO(255, 193, 84, 1)),
                          child: IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSheet()),
                                );
                              }),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 70),
              buildTextField('ent mail'.tr, false, omail),
              buildTextField('ent pass'.tr, true, opass),
              buildTextField('ent new name'.tr, false, nuser),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (contest) => SettingPageUI(),
                          ),
                        );
                      },
                      child: Text(
                        'cancel'.tr,
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(backgroundColor: Color.fromRGBO(0, 147, 171, 1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // postData();
                      },
                      child: Text('save'.tr,
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.white,
                          )),
                      style: OutlinedButton.styleFrom(backgroundColor: Color.fromRGBO(0, 147, 171, 1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String placeholder, bool isPasswordTextField, var controll) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextFormField(
          style: TextStyle(
              //color: appServices.isDark.value ? Colors.white : Colors.black,
              ),
          controller: controll,
          obscureText: isPasswordTextField ? isObsecurePassword : false,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: isPasswordTextField
                ? IconButton(
                    icon: Icon(Icons.remove_red_eye, color: Color.fromRGBO(255, 193, 84, 1)),
                    onPressed: () {
                      setState(() {
                        isObsecurePassword = !isObsecurePassword;
                      });
                    })
                : null,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          )),
    );
  }

  Widget bottomSheet() {
    return Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: <Widget>[
            Text(
              'choose'.tr,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton.icon(
                    icon: Icon(Icons.camera),
                    onPressed: () {
                      takePhoto(ImageSource.camera);
                    },
                    label: Text('camera'.tr)),
                FlatButton.icon(
                  icon: Icon(Icons.image),
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  label: Text('gallery'.tr),
                )
              ],
            )
          ],
        ));
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    appServices.profileImage.value = pickedFile.path;
    SharedPrefsHelper.storePic(pickedFile.path);
  }
}
