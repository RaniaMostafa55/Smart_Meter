import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';
import '../services/app_services.dart';
import '../services/shared_helper.dart';
import '../services/translation_service.dart';
import 'package:get/get.dart';

class Pay extends StatefulWidget {
  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  var responsebody;
  Future getData() async {
    var url = "https://rooot.azurewebsites.net/generate/Bill?userId=${SharedHelper.getId()}";
    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  final appServices = Get.find<AppServices>();
  final translationServices = Get.find<TranslationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              "your bill".tr,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 147, 171, 1)),
            ),
          ),
          FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Color.fromRGBO(0, 147, 171, 1),
                ));
              } else {
                return Container(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text("id".tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromRGBO(0, 147, 171, 1),
                                  )),
                              Text(snapshot.data['users']['id'].toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: appServices.isDark.value ? Colors.white : Colors.black,
                                  )),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text('name'.tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromRGBO(0, 147, 171, 1),
                                  )),
                              Text(
                                snapshot.data['users']['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: appServices.isDark.value ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text('your mail'.tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromRGBO(0, 147, 171, 1),
                                  )),
                              Text(snapshot.data['users']['email'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: appServices.isDark.value ? Colors.white : Colors.black,
                                  )),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text('state'.tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromRGBO(0, 147, 171, 1),
                                  )),
                              Text(snapshot.data['users']['state'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: appServices.isDark.value ? Colors.white : Colors.black,
                                  )),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text('phone'.tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromRGBO(0, 147, 171, 1),
                                  )),
                              Text(snapshot.data['users']['phone'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: appServices.isDark.value ? Colors.white : Colors.black,
                                  )),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text('address'.tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromRGBO(0, 147, 171, 1),
                                  )),
                              Text(snapshot.data['users']['address'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: appServices.isDark.value ? Colors.white : Colors.black,
                                  )),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text('energyy'.tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromRGBO(0, 147, 171, 1),
                                  )),
                              Text(snapshot.data['energy'].toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: appServices.isDark.value ? Colors.white : Colors.black,
                                  )),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text('costt'.tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromRGBO(0, 147, 171, 1),
                                  )),
                              Text(snapshot.data['amount'].toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: appServices.isDark.value ? Colors.white : Colors.black,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
              }
            },
          ),
          SizedBox(height: 20),
          MaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            shape: StadiumBorder(),
            color: Color.fromRGBO(0, 147, 171, 1),
            onPressed: () {
              _launchUrl('https://rooot.azurewebsites.net/checkout?userId=1');
            },
            child: Text("paay".tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                )),
          ),
          SizedBox(height: 20),
          Lottie.asset('assets/pay1.json'),
        ],
      ),
    ));
  }

  Future<void> _launchUrl(String urlString) async {
    if (await canLaunch(urlString)) {
      await launch(
        urlString,
      );
    } else {
      print('Can\'t launch Url');
    }
  }
}
