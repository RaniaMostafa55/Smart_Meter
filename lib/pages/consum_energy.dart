import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import '../models/consum_model.dart';
import '../services/network_helper.dart';
import '../services/app_services.dart';
import '../services/shared_helper.dart';
import '../services/translation_service.dart';
import 'package:get/get.dart';

class ConsumEnergy extends StatefulWidget {
  const ConsumEnergy({Key key}) : super(key: key);

  @override
  State<ConsumEnergy> createState() => _ConsumEnergyState();
}

class _ConsumEnergyState extends State<ConsumEnergy> {
  List<ConsumModel> consumption = [];
  bool loading = false;
  NetworkHelper _networkHelper = NetworkHelper();

  void getData() async {
    setState(() {
      loading = true;
    });
    var response = await _networkHelper.get("https://rooot.azurewebsites.net/reading/get/period?userId=${SharedHelper.getId()}&start=${start}&end=${end}");
    if (response.statusCode == 200) {
      List<ConsumModel> tempdata = consumModelFromJson(response.body);
      print(response.body);
      setState(() {
        loading = false;
        consumption = tempdata;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  List<charts.Series<ConsumModel, String>> _createSampleData() {
    return [
      charts.Series<ConsumModel, String>(
        data: consumption,
        id: 'sales',
        colorFn: (_, __) => charts.Color.fromHex(code: '#FFC154'),
        domainFn: (ConsumModel consumModel, _) => consumModel.date,
        measureFn: (ConsumModel consumModel, _) => consumModel.energy,
      )
    ];
  }

  final translationServices = Get.find<TranslationService>();
  final appServices = Get.find<AppServices>();
  DateTime _startTime;
  String start;
  DateTime _endTime;
  String end;

  @override
  Widget build(BuildContext context) {
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
                      'start'.tr,
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
              children: <Widget>[
                Container(
                  width: 140,
                  child: RaisedButton(
                    color: Color.fromRGBO(0, 147, 171, 1),
                    child: Text(
                      'end'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: _endTime == null ? DateTime.now() : _endTime,
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2080),
                      ).then((date) {
                        setState(() {
                          _endTime = date;
                          end = DateFormat('yyyy-MM-dd').format(_endTime).toString();
                        });
                      });
                    },
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  _endTime == null ? 'nothing'.tr : (end),
                  style: TextStyle(
                    color: appServices.isDark.value ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                MaterialButton(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: StadiumBorder(),
                  color: Color.fromRGBO(0, 147, 171, 1),
                  child: Text(
                    'show cons'.tr,
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
                : Container(
                    height: 500,
                    child: charts.BarChart(
                      _createSampleData(),
                      animate: true,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
