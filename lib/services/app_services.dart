import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'shared_prefs.dart';

class AppServices extends GetxService {
  /*--------------------------------------------------------------------------*/
  /*------------------------------  Variables  -------------------------------*/
  /*--------------------------------------------------------------------------*/
  RxBool isDark = false.obs;
  RxBool isLoggedin = false.obs;
  RxString profileImage = "".obs;
  @override
  onInit() {
    super.onInit();
    getisLoggedinFromPrefs();
    getThemeFromPrefs();
    getprofileImage();
  }
  /*--------------------------------------------------------------------------*/
  /*---------------------------  Save Functions  -----------------------------*/
  /*--------------------------------------------------------------------------*/

  changeTheme(bool value) {
    isDark.value = value;
    SharedPrefsHelper.saveTheme(value);
  }

  getThemeFromPrefs() async {
    bool val = await SharedPrefsHelper.checkTheme();
    if (val) {
      isDark.value = await SharedPrefsHelper.getTheme();
    } else {
      isDark.value = false;
    }
  }

  getprofileImage() async {
    String value = await SharedPrefsHelper.getPic();
    if (value != null) {
      profileImage.value = value;
    }
  }

  changeisLoggedin(bool value) {
    isLoggedin.value = value;
    SharedPrefsHelper.storeisLoggedin(value);
  }

  getisLoggedinFromPrefs() async {
    bool val = await SharedPrefsHelper.getisLoggedin() ?? false;
    isLoggedin.value = val;
  }

  /*--------------------------------------------------------------------------*/
  /*--------------------------  user info  Functions  ----------------------------*/
  /*--------------------------------------------------------------------------*/
}
