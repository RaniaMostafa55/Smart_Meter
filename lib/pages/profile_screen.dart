import 'dart:convert';
import 'dart:io';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import '../models/user_data_model.dart';
import '../services/shared_helper.dart';
import 'about_us.dart';
import 'appliance.dart';
import 'contact.dart';
import 'consum_tabs.dart';
import 'logIn.dart';
import 'bill_tabs.dart';
import 'question.dart';
import 'setting_page.dart';
import 'package:get/get.dart';
import '../services/app_services.dart';
import '../services/translation_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final translationServices = Get.find<TranslationService>();
  final appServices = Get.find<AppServices>();
  final double coverHeight = 280;
  final double profileHeight = 144;

  Future<UserDataModel> gettData() async {
    print("B7bk");
    //int id = SharedHelper.getId();
    var response = await http.get(Uri.parse("https://rooot.azurewebsites.net/user/find/ById?id=30"));
    print("B7bk tany");
    //var responsebody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      UserDataModel b7bk = userDataModelFromJson(response.body);
      await SharedHelper.setUsername(b7bk.name);
      print(b7bk);
      return b7bk;
    } else {
      print('ya 7maaaaaaaar');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight / 2;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
        ],
      ),
    );
  }

  Widget buildContent() => Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          /*Text(
            "iskra",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: appServices.isDark.value ? Colors.white : Colors.black,
            ),
          ),*/
          FutureBuilder<UserDataModel>(
            future: gettData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData || snapshot == null) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Color.fromRGBO(0, 147, 171, 1),
                ));
              } else {
                return Text(
                  "${snapshot.data.name}",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: appServices.isDark.value ? Colors.white : Colors.black,
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 16),
          Divider(),
          buildCard("assets/cons.jpg", "conss".tr, () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (contest) => ConsumTabs(),
              ),
            );
          }),
          buildCard("assets/pay.jpg", "b&p".tr, () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (contest) => BillTabs(),
              ),
            );
          }),
          buildCard("assets/appliance.jpg", "app".tr, () {
            appServices.changeisLoggedin(false);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (contest) => Appliance(),
              ),
            );
          }),
          buildCard("assets/faq.jpg", "faq".tr, () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (contest) => Questions(),
              ),
            );
          }),
          buildCard("assets/contact.jpg", "contact".tr, () {
            appServices.changeisLoggedin(false);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (contest) => Contact(),
              ),
            );
          }),
          buildCard("assets/about.jpg", "about us".tr, () {
            appServices.changeisLoggedin(false);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (contest) => About(),
              ),
            );
          }),
          buildCard("assets/setting.jpg", "settings".tr, () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (contest) => SettingPageUI(),
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (contest) => Login(),
                        ),
                      );
                    },
                    leading: Icon(Icons.logout_outlined, color: Color.fromRGBO(0, 147, 171, 1)),
                    title: Text("logout".tr,
                        style: TextStyle(
                          color: appServices.isDark.value ? Colors.white : Colors.black,
                        )),
                    trailing: Icon(Icons.keyboard_arrow_right_outlined, color: Color.fromRGBO(0, 147, 171, 1)),
                  ),
                ),
              ),
            ),
          )
        ],
      );

  Widget buildTop() {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileImage(),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset(
          'assets/meter1.jpg',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );
  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: appServices.profileImage.value.isEmpty
            ? AssetImage('assets/girl.png')
            : FileImage(
                File(appServices.profileImage.value),
              ),
      );

  Widget buildCard(String img, String tit, Function onTapp) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Container(
          height: 170,
          child: Column(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      img,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListTile(
                  onTap: onTapp,
                ),
              ),
              ListTile(
                onTap: onTapp,
                title: Text(tit,
                    style: TextStyle(
                      color: appServices.isDark.value ? Colors.white : Colors.black,
                    )),
                trailing: Icon(Icons.keyboard_arrow_right_outlined, color: Color.fromRGBO(0, 147, 171, 1)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
