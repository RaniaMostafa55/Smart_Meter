import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import '../services/app_services.dart';
import '../services/network_helper.dart';
import '../services/translation_service.dart';
import 'profile_screen.dart';

class Appliance extends StatefulWidget {
  @override
  State<Appliance> createState() => _ApplianceState();
}

class _ApplianceState extends State<Appliance> {
  NetworkHelper _networkHelper = NetworkHelper();

  Future getData() async {
    var url = "https://rooot.azurewebsites.net/payment/get/by/date?userId=30&date=2022-06-22";
    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

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
          title: Text("app".tr,
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Lottie.asset('assets/appliance.json'),
                );
              } else {
                return ListView(children: [
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildSlider(
                          "fridge".tr,
                          50 / 1000 * 100,
                          150,
                          70,
                          "assets/fridge.png",
                          //snapshot.data[0]["resetNo"].toString(),
                          '50 watt',
                          //snapshot.data[0]["amount"].toString(),
                          "OFF",
                        ),
                        SizedBox(width: 50),
                        buildSlider(
                          "cooker".tr,
                          100 / 1000 * 100,
                          140,
                          60,
                          "assets/cooker.png",
                          //snapshot.data[0]["resetNo"].toString(),
                          "100 watt",
                          //snapshot.data[0]["amount"].toString(),
                          "ON",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildSlider(
                          "tv".tr,
                          1000 / 1000 * 100,
                          120,
                          60,
                          "assets/TV.png",
                          //snapshot.data[1]["resetNo"].toString(),
                          "1000 watt",
                          //snapshot.data[1]["amount"].toString(),
                          "OFF",
                        ),
                        SizedBox(width: 50),
                        buildSlider(
                          "kettle".tr,
                          500 / 1000 * 100,
                          150,
                          70,
                          "assets/kettle.png",
                          '500 watt',
                          "ON",
                        ),
                      ],
                    ),
                  ),
                ]);
              }
            }));
  }

  Widget buildSlider(String name, double val, double wid, double hit, String imge, String amount, String cas) {
    return CircularPercentIndicator(
      radius: 150.0,
      lineWidth: 15.0,
      percent: val / 100,
      animation: true,
      animationDuration: 1500,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: wid,
            height: hit,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imge),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: appServices.isDark.value ? Colors.white : Colors.black,
              )),
        ],
      ),
      footer: Column(
        children: [
          SizedBox(height: 5),
          new Text(
            amount,
            style: TextStyle(fontSize: 20, color: Color.fromRGBO(0, 147, 171, 1)),
          ),
          SizedBox(height: 5),
          new Text(
            cas,
            style: TextStyle(fontSize: 20, color: Color.fromRGBO(0, 147, 171, 1)),
          ),
        ],
      ),
      progressColor: Color.fromRGBO(255, 193, 84, 1),
    );
  }
}
