import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/app_services.dart';
import '../services/translation_service.dart';
import 'edit.dart';
import 'edit_password.dart';
import 'profile_screen.dart';

class SettingPageUI extends StatefulWidget {
  @override
  _SettingPageUIState createState() => _SettingPageUIState();
}

class _SettingPageUIState extends State<SettingPageUI> {
  //bool valNotify1 = false;
  bool valNotify2 = false;
  bool valNotify3 = false;
  final appServices = Get.find<AppServices>();

  final translationServices = Get.find<TranslationService>();

  onChangeFunction1(bool newValue1) {
    /*setState(() {
      valNotify1 = newValue1;
    });*/
    appServices.changeTheme(newValue1);
  }

  onChangeFunction2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  onChangeFunction3(bool newValue3) {
    setState(() {
      valNotify3 = newValue3;
    });
  }

  showLanguageDialog(context, int type) {
    final List titles = [
      'ar'.tr,
      'english'.tr
    ];
    final appServices = Get.find<AppServices>();
    final translationServices = Get.find<TranslationService>();
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, c) {
        return Dialog(
          backgroundColor: (appServices.isDark.value) ? Colors.grey.shade700 : Colors.white,
          insetPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'lang'.tr,
                    style: Get.textTheme.headline6.copyWith(color: (appServices.isDark.value) ? Colors.white : Colors.black),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    TranslationService.languages.length,
                    (index) {
                      var _lang = TranslationService.languages.elementAt(index);
                      return RadioListTile<String>(
                        // checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.trailing,
                        groupValue: Get.locale.toString(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        activeColor: Color.fromRGBO(255, 193, 84, 1),
                        title: Text(
                          titles[index],
                          style: Get.textTheme.bodyText1.copyWith(color: Colors.grey),
                        ),
                        value: _lang,
                        onChanged: (val) {
                          translationServices.updateLocale(val);
                          Get.back();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

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
          title: Text("settings".tr,
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          //automaticallyImplyLeading: true,
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                SizedBox(height: 40),
                Row(
                  children: [
                    Icon(
                      Icons.settings_display,
                      color: Color.fromRGBO(255, 193, 84, 1),
                    ),
                    SizedBox(width: 10),
                    Text("general settings".tr,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: appServices.isDark.value ? Colors.white : Colors.black,
                        ))
                  ],
                ),
                Divider(height: 30, thickness: 1),
                SizedBox(height: 10),
                buildAccountOption(context, "Languages".tr, () {
                  showLanguageDialog(context, 2);
                }),
                SizedBox(height: 30),
                buildNotificationOption('dark mode'.tr, appServices.isDark.value, onChangeFunction1),
                SizedBox(height: 40),
                Row(
                  children: [
                    Icon(Icons.person, color: Color.fromRGBO(255, 193, 84, 1)),
                    SizedBox(width: 10),
                    Text('user settings'.tr,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: appServices.isDark.value ? Colors.white : Colors.black,
                        ))
                  ],
                ),
                Divider(height: 20, thickness: 1),
                SizedBox(height: 10),
                buildAccountOption(context, 'edit username'.tr, () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (contest) => EditProfileUI(),
                    ),
                  );
                }),
                SizedBox(height: 30),
                buildAccountOption(context, 'edit pass'.tr, () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (contest) => EditPasswordUI(),
                    ),
                  );
                }),
              ],
            )));
  }
}

Padding buildNotificationOption(String title, bool value, Function onChangeMethod) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey[600])),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            activeColor: Color.fromRGBO(255, 193, 84, 1),
            trackColor: Colors.grey,
            value: value,
            onChanged: (bool newValue) {
              onChangeMethod(newValue);
            },
          ),
        )
      ],
    ),
  );
}

GestureDetector buildAccountOption(BuildContext context, String title, Function onTapp) {
  return GestureDetector(
    onTap: onTapp,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey[600])),
          Icon(Icons.arrow_forward_ios, color: Colors.grey)
        ],
      ),
    ),
  );
}
