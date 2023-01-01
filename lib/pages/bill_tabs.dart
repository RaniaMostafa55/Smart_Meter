import 'package:flutter/material.dart';
import 'package:Smart_Meter/pages/show_prev.dart';
import 'pay.dart';
import 'show_prev.dart';
import 'profile_screen.dart';
import '../services/translation_service.dart';
import 'package:get/get.dart';
import '../services/app_services.dart';

class BillTabs extends StatelessWidget {
  final translationServices = Get.find<TranslationService>();
  final appServices = Get.find<AppServices>();
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
          title: Text('b&p'.tr,
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          bottom: TabBar(
            tabs: [
              Tab(text: 'paay'.tr),
              Tab(text: 'prev'.tr)
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Pay(),
            ShowPrev(),
          ],
        ),
      ),
    );
  }
}
