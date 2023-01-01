import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'forget.dart';
import 'profile_screen.dart';
import '../services/app_services.dart';
import '../services/translation_service.dart';
import '../models/login_req_model.dart';
import 'package:dio/dio.dart';
import '../services/shared_helper.dart';
import '../models/login_model.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final translationServices = Get.find<TranslationService>();
  final appServices = Get.find<AppServices>();

  bool check = true;
  bool load = false;
  var email = TextEditingController();
  var pass = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String mail, passwd;

  void log() async {
    load = true;
    try {
      var response = await Dio().post(
        'https://rooot.azurewebsites.net/login',
        data: LoginModel(name: mail, password: passwd).toJson(),
      );
      LoginResponseModel responseModel = LoginResponseModel.fromJson(response.data);
      await SharedHelper.set(responseModel.accessToken);
      await SharedHelper.setId(responseModel.userId);
      print(SharedHelper.get());
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (contest) => MainPage(),
        ),
      );
      print(response);
      load = false;
    } catch (e) {
      load = false;
      print(e);
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
        //backgroundColor: Colors.white,
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo2.png',
          color: Color.fromRGBO(0, 147, 171, 1),
        ),
        Container(
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                    child: TextFormField(
                      //TODO::changing the color
                      style: TextStyle(
                        color: appServices.isDark.value ? Colors.white : Colors.black,
                      ),
                      controller: email,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "User".tr,
                        hintText: "user validate empty".tr,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color.fromRGBO(255, 193, 84, 1),
                        ),
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "please user".tr;
                        } else {
                          return null;
                        }
                      },
                      onSaved: (String value) {
                        setState(() {
                          mail = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: TextFormField(
                      style: TextStyle(
                        color: appServices.isDark.value ? Colors.white : Colors.black,
                      ),
                      obscureText: check,
                      controller: pass,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Password'.tr,
                        hintText: "pass validate empty".tr,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock, color: Color.fromRGBO(255, 193, 84, 1)),
                        suffixIcon: IconButton(
                            icon: Icon(Icons.remove_red_eye, color: Color.fromRGBO(255, 193, 84, 1)),
                            onPressed: () {
                              setState(() {});
                              (check = !check);
                            }),
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "please password".tr;
                        } else if (value.length < 6) {
                          return "6 digit".tr;
                        } else {
                          return null;
                        }
                      },
                      onSaved: (String value) {
                        setState(() {
                          passwd = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
        MaterialButton(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: StadiumBorder(),
          color: Color.fromRGBO(0, 147, 171, 1),
          child: load
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text(
                  'Login'.tr,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
          onPressed: () {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
              log();
              appServices.changeisLoggedin(true);
            }
          },
        ),
        SizedBox(height: 7),
        TextButton(
            child: Text("Forgot Password?".tr,
                style: TextStyle(
                  color: appServices.isDark.value ? Colors.white : Colors.black,
                  fontSize: 17,
                )),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (contest) => Forget(),
                ),
              );
            })
      ],
    ));
  }
}
