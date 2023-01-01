import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_screen.dart';
import 'package:get/get.dart';
import '../services/app_services.dart';
import '../services/translation_service.dart';

class About extends StatelessWidget {
  final appServices = Get.find<AppServices>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 147, 171, 1),
        title: Text("about us".tr,
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
                  builder: (contest) => MainPage(),
                ),
              );
            }),
      ),
      body: ListView(
        children: [
          Container(
            width: 400,
            height: 350,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/about.png'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Text(
                'Electricity is not a free resource and an important national treasure. Electricity generation and its distribution are a major concern and need to be properly handled by governments. Electricity meter technology advancements in recent years were essential for monitoring and managing electricity consumption as the electricity generation sector in Egypt is responsible for approximately 40% of the country’s total CO2 emissions. So there was a huge need for replacing the traditional electricity meters with smart electricity meters for more accuracy, efficiency, features, privacy, security, and visibility in electricity measurements. Thus, enabling a better understanding of energy usage patterns and the ability to improve customer experience, consumption monitoring through web and mobile management systems, grid reliability, outage management, and operational efficiency with the AI bills and household appliances prediction for usage recommendations. We believe that this idea can improve and change the traditional electricity metering systems into more productive, conserving, and efficient ones.',
                style: TextStyle(
                  height: 1.5,
                  fontSize: 17,
                  color: appServices.isDark.value ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          )
        ],
      ),
    );
  }
}
