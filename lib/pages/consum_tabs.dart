import 'package:flutter/material.dart';
import 'appliance.dart';
import 'consum_energy.dart';
import 'consum_cost.dart';
import 'profile_screen.dart';
import '../services/translation_service.dart';
import 'package:get/get.dart';
import '../services/app_services.dart';

class ConsumTabs extends StatelessWidget {
  final translationServices = Get.find<TranslationService>();
  final appServices = Get.find<AppServices>();
  DateTime _startTime;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          title: Text('conss'.tr,
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          bottom: TabBar(
            tabs: [
              Tab(text: 'consum'.tr),
              Tab(text: 'cost'.tr),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ConsumEnergy(),
            Consum_Amount(),
            Appliance(),
          ],
        ),
      ),
    );
  }
}
