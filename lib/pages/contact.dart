import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'utils.dart';
import 'profile_screen.dart';
import 'package:get/get.dart';
import '../services/app_services.dart';
import '../services/translation_service.dart';

class Contact extends StatelessWidget {
  final translationServices = Get.find<TranslationService>();
  final appServices = Get.find<AppServices>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 147, 171, 1),
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (contest) => MainPage(),
                  ),
                );
              }),
          title: Text("contact".tr,
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 120),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        Text(
                          "you can".tr,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: appServices.isDark.value ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(right: 1.8, left: 1.8),
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            child: Card(
                              child: ListTile(
                                title: Text(
                                  "via ph".tr,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: appServices.isDark.value ? Colors.white : Colors.black,
                                  ),
                                ),
                                leading: Image.asset(
                                  'assets/phone-call.png',
                                  width: 30,
                                  color: Color.fromRGBO(255, 193, 84, 1),
                                ),
                                onTap: () {
                                  Utils.openPhone(
                                    phoneNumber: '01117199897',
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 60,
                            child: Card(
                              child: ListTile(
                                title: Text(
                                  "via SMS".tr,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: appServices.isDark.value ? Colors.white : Colors.black,
                                  ),
                                ),
                                leading: Image.asset(
                                  'assets/chatting.png',
                                  width: 30,
                                  color: Color.fromRGBO(255, 193, 84, 1),
                                ),
                                onTap: () {
                                  Utils.openMessage(phoneNumber: '01117199897');
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 60,
                            child: Card(
                              child: ListTile(
                                title: Text(
                                  "via mail".tr,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: appServices.isDark.value ? Colors.white : Colors.black,
                                  ),
                                ),
                                leading: Image.asset(
                                  'assets/message.png',
                                  width: 30,
                                  color: Color.fromRGBO(255, 193, 84, 1),
                                ),
                                onTap: () {
                                  Utils.openEmail(
                                    toEmail: 'example@gmail.com',
                                    subject: "Help",
                                    body: "Help me with...",
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Lottie.asset("assets/contact.json"),
            ],
          ),
        ));
  }
}
