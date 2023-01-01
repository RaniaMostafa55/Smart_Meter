import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'logIn.dart';
import 'profile_screen.dart';
import '../services/app_services.dart';
import '../services/translation_service.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final translationServices = Get.find<TranslationService>();
  final appServices = Get.find<AppServices>();

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 1400), () {
      if (appServices.isLoggedin.value == false) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 300, height: 200, child: Image.asset("assets/logo.png", color: Color.fromRGBO(0, 147, 171, 1))),
                Container(height: 250, width: 300, child: Lottie.asset("assets/s3.json")),
              ],
            )));
  }
}
