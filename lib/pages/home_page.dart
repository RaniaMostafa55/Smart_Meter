import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../services/shared_helper.dart';
import 'profile_screen.dart';
import '../services/app_services.dart';
import '../services/translation_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

//import 'profile_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final translationServices = Get.find<TranslationService>();
  final appServices = Get.find<AppServices>();
  DateTime startTime;
  DateTime endTime;
  String start;
  String end;
  bool isLoading = false;
  List responsebody = [];
  Future getData() async {
    setState(() {
      isLoading = true;
    });
    var url = "https://rooot.azurewebsites.net/reading/get/period?start=${start}&end=${end}";
    //var url = "https://rooot.azurewebsites.net/reading/get/period?start=2022-02-01&end=2022-02-28";
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': SharedHelper.get()
    });

    setState(() {
      responsebody = jsonDecode(response.body);
      isLoading = false;
    });
    return responsebody;
  }

  List<charts.Series<WorldPopulation, String>> first;
  Widget build(BuildContext context) {
    if (responsebody.isNotEmpty) {
      setState(() {
        first = [
          charts.Series(
            data:
                //List<WorldPopulation>.generate(
                //7,
                //(index) => WorldPopulation('${index + 1}', responsebody[index]['volt'], Colors.pink),
                //),
                [
              WorldPopulation('1', responsebody[0]['volt'], Colors.pink),
              WorldPopulation('2', responsebody[1]['volt'], Colors.purple),
              WorldPopulation('3', responsebody[2]['volt'], Colors.yellow),
              WorldPopulation('4', responsebody[3]['volt'], Colors.amber),
              WorldPopulation('5', responsebody[4]['volt'], Colors.green),
              WorldPopulation('6', responsebody[5]['volt'], Colors.indigo),
              WorldPopulation('7', responsebody[6]['volt'], Colors.teal),
            ],
            id: "World Population",
            domainFn: (WorldPopulation pops, _) => pops.year,
            measureFn: (WorldPopulation pops, _) => pops.population,
            colorFn: (WorldPopulation pops, _) => charts.ColorUtil.fromDartColor(pops.barColor),
          )
        ];
      });
    }
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(0, 147, 171, 1),
            title: Text('cons'.tr,
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
          body: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 90,
                    child: RaisedButton(
                      child: Text(
                        'Start date',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () async {
                        var picker = await showDatePicker(
                          context: context,
                          initialDate: startTime ?? DateTime.now(),
                          firstDate: DateTime(1000),
                          lastDate: DateTime(3000),
                          initialDatePickerMode: DatePickerMode.day,
                        );
                        if (picker != null) {
                          setState(() {
                            startTime = picker;
                            start = DateFormat('yyyy-MM-dd').format(startTime);
                            print(start);
                          });
                        }
                      },
                    ),
                  ),
                  Text(
                    startTime == null ? 'Nothing has been picked yet' : DateFormat('yyyy-MM-dd').format(startTime),
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 90,
                    child: RaisedButton(
                      child: Text(
                        'End date',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () async {
                        var picker = await showDatePicker(
                          context: context,
                          initialDate: endTime ?? DateTime.now(),
                          firstDate: DateTime(1000),
                          lastDate: DateTime(3000),
                          initialDatePickerMode: DatePickerMode.day,
                        );
                        if (picker != null) {
                          setState(() {
                            endTime = picker;
                            end = DateFormat('yyyy-MM-dd').format(endTime);
                            print(end);
                          });
                        }
                      },
                    ),
                  ),
                  Text(
                    endTime == null ? 'Nothing has been picked yet' : DateFormat('yyyy-MM-dd').format(endTime),
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 20),
              MaterialButton(
                child: Text("Show Consumption"),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  var url = "https://rooot.azurewebsites.net/reading/get/period?start=${start}&end=${end}";
                  //var url = "https://rooot.azurewebsites.net/reading/get/period?start=2022-02-01&end=2022-02-28";
                  var response = await http.get(Uri.parse(url), headers: {
                    'Authorization': SharedHelper.get()
                  });

                  setState(() {
                    isLoading = false;
                  });
                  //getData();
                },
              ),
              // FutureBuilder(
              //     future: getData(),
              //     builder: (context, snapshot) {
              //       if (!snapshot.hasData) {
              //         return Center(
              //             child: CircularProgressIndicator(
              //           valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
              //         ));
              //       } else if (snapshot.data.isEmpty) {
              //         return Center(child: Text('THERE IS NO DATA'));
              //       } else {

              //       }
              //     }),
              (responsebody.isNotEmpty)
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Expanded(
                        child: Container(
                          width: 500,
                          child: charts.BarChart(
                            first,
                          ),
                        ),
                      ),
                    )
                  : (isLoading)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Center(
                          child: Text("THERE IS NO DATA"),
                        ),
            ],
          )),
    );
  }
}

class WorldPopulation {
  final String year;
  final double population;
  final Color barColor;

  WorldPopulation(this.year, this.population, this.barColor);
}
