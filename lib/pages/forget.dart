import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/app_services.dart';
import '../services/translation_service.dart';
import 'package:get/get.dart';
import 'logIn.dart';

class Forget extends StatelessWidget {
  var mail = TextEditingController();
  final translationServices = Get.find<TranslationService>();
  final appServices = Get.find<AppServices>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            width: 400,
            height: 350,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/forget.png"))),
          ),
        ),
        SizedBox(height: 20),
        Text(
          "forget".tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: appServices.isDark.value ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
          child: TextFormField(
            //TODO::changing the color
            style: TextStyle(),
            controller: mail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "mail".tr,
              hintText: "maill".tr,
              border: OutlineInputBorder(),
              prefixIcon: Icon(
                Icons.email,
                color: Color.fromRGBO(255, 193, 84, 1),
              ),
            ),
          ),
        ),
        SizedBox(height: 40),
        MaterialButton(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: StadiumBorder(),
          color: Color.fromRGBO(0, 147, 171, 1),
          child: Text(
            "reset".tr,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          onPressed: () {},
        ),
        SizedBox(height: 7),
        TextButton(
            child: Text("go".tr,
                style: TextStyle(
                  fontSize: 17,
                  color: appServices.isDark.value ? Colors.white : Colors.black,
                )),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (contest) => Login(),
                ),
              );
            })
      ]),
    ));
  }
}
