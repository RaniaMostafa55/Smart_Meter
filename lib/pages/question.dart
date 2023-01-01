import 'package:flutter/material.dart';
import '../services/app_services.dart';
import '../services/translation_service.dart';
import 'package:get/get.dart';
import 'profile_screen.dart';

class Questions extends StatelessWidget {
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
        title: Text("freq".tr,
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: ListTile(
                  title: Text(
                    "how does the system work?".tr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 147, 171, 1),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "a smart grid system is able to collect consumption data and pass them between some meters until they reach the head-end system.".tr,
                      style: TextStyle(
                        fontSize: 17,
                        color: appServices.isDark.value ? Colors.white : Colors.black,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ListTile(
                    title: Text(
                      "how does head-end system benefit from the collected data?".tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 147, 171, 1),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "* it can calculate your bill monthly.\n* Tells you how much energy do your appliances consume.\n* Helps you save your energy consumption.\n* Provides you with the needed energy.".tr,
                        style: TextStyle(
                          fontSize: 17,
                          color: appServices.isDark.value ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ListTile(
                    title: Text(
                      "how could this application help you?".tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 147, 171, 1),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "with this application you can:\n* Show your consumption.\n* Pay your bill.\n* Contact us if you have any problem.\n* Show your old bills.\n* Show each appliance's consumption.\n* Edit your own data.".tr,
                        style: TextStyle(
                          fontSize: 17,
                          color: appServices.isDark.value ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ListTile(
                    title: Text(
                      "how could you show  your consumption?".tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 147, 171, 1),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "you should only select the month and week and then press the button \"Show Consumption\".".tr,
                        style: TextStyle(
                          fontSize: 17,
                          color: appServices.isDark.value ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ListTile(
                    title: Text(
                      "how could you pay your bill?".tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 147, 171, 1),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "you have to enter some data about your credit card and then press the button \"Pay Bill\".".tr,
                        style: TextStyle(
                          fontSize: 17,
                          color: appServices.isDark.value ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ListTile(
                    title: Text(
                      "how could you contact us?".tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 147, 171, 1),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "you could contact us by calling us, sending SMS or sending a mail to tell us about your problem.".tr,
                        style: TextStyle(
                          fontSize: 17,
                          color: appServices.isDark.value ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ListTile(
                    title: Text(
                      "how could you show your old bills?".tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 147, 171, 1),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "all you have to do is to select the month you want and then press the button \"Show Bill\".".tr,
                        style: TextStyle(
                          fontSize: 17,
                          color: appServices.isDark.value ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
          ),
        ],
      ),
    );
  }
}
