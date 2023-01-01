import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../services/app_services.dart';
import '../services/shared_helper.dart';
import '../services/translation_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/previous_model.dart';
import '../services/network_helper.dart';

class ShowPrev extends StatefulWidget {
  const ShowPrev({Key key}) : super(key: key);

  @override
  State<ShowPrev> createState() => _ShowPrevState();
}

class _ShowPrevState extends State<ShowPrev> {
  NetworkHelper _networkHelper = NetworkHelper();
  void getData() async {
    setState(() {
      loading = true;
    });
    var url = "https://rooot.azurewebsites.net/payment/get/by/date?userId=${SharedHelper.getId()}&date=${start}";
    var response = await _networkHelper.get(url);
    if (response.statusCode == 200) {
      List<PreviousModel> tempdata = previousModelFromJson(response.body);

      setState(() {
        loading = false;
        previousModel = tempdata;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  List<PreviousModel> previousModel = [];
  final translationServices = Get.find<TranslationService>();
  final appServices = Get.find<AppServices>();
  DateTime _startTime;
  String start;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 35),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: 140,
                  child: RaisedButton(
                    color: Color.fromRGBO(0, 147, 171, 1),
                    child: Text(
                      'pick'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: _startTime == null ? DateTime.now() : _startTime,
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2080),
                      ).then((date) {
                        setState(() {
                          _startTime = date;
                          start = DateFormat('yyyy-MM-dd').format(_startTime).toString();
                        });
                      });
                    },
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  _startTime == null ? 'nothing'.tr : (start),
                  style: TextStyle(
                    color: appServices.isDark.value ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                MaterialButton(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: StadiumBorder(),
                  color: Color.fromRGBO(0, 147, 171, 1),
                  child: Text(
                    'show bill'.tr,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    getData();
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            (loading)
                ? Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(0, 147, 171, 1),
                    ),
                  )
                : (previousModel.isEmpty)
                    ? Center(
                        child: Text('no data'.tr,
                            style: TextStyle(
                              color: appServices.isDark.value ? Colors.white : Colors.black,
                            )),
                      )
                    : Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
                                      Row(
                                        children: [
                                          Text("amount".tr,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Color.fromRGBO(0, 147, 171, 1),
                                              )),
                                          Text(previousModel[0].amount.toString(),
                                              style: TextStyle(
                                                fontSize: 18,
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text('reset'.tr,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Color.fromRGBO(0, 147, 171, 1),
                                              )),
                                          Text(
                                            previousModel[0].resetNo.toString(),
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text('pay date'.tr,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Color.fromRGBO(0, 147, 171, 1),
                                              )),
                                          Text(
                                            previousModel[0].paymentDate.toString(),
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ])),
                              ),
                            ),
                          ],
                        ),
                      ),
            SizedBox(height: 20),
            Lottie.asset('assets/prevbill.json'),
          ],
        ),
      ),
    );
  }
}
